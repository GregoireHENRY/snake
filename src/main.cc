#include <iostream>
#include <SFML/Graphics.hpp>

const int MAX_WIDTH_SCREEN = 1024;
const int MAX_HEIGHT_SCREEN = 768;
const int PIXEL_SIZE = 20;
const int MAX_WIDTH = MAX_WIDTH_SCREEN / PIXEL_SIZE;
const int MAX_HEIGHT = MAX_HEIGHT_SCREEN / PIXEL_SIZE;
const sf::Vector2f PIXEL(PIXEL_SIZE, PIXEL_SIZE);
const sf::Color ENTITY_COLOR[2] = {sf::Color::White, sf::Color::Red};
sf::Font FONT;

class Point {
private:
    int x, y;
public:
    Point() {}
    Point(int x, int y): x(x), y(y) {}
    int getx() const { return x; }
    int gety() const { return y; }
    void setx(int _x) { x = _x; }
    void sety(int _y) { y = _y; }
    void update(const Point& oth) {
        x = oth.x;
        y = oth.y;
    }
    void updateRandom() {
        x = std::rand() % (MAX_WIDTH-1) + 1;
        y = std::rand() % (MAX_HEIGHT-1) + 1;
    }
    void move(int up, int right) {
        y -= up;
        x += right;
    }
    bool compare(const Point& oth) {
        return x == oth.x && y == oth.y;
    }
};

class Entity {
private:
    int type; // 0: snake, 1: apple
    Point p;
    sf::RectangleShape shape;
public:
    Entity() {}
    Point& getp() { return p; }
    void setp(const Point& _p) { p.update(_p); }
    void spawn(int _type) {
        type = _type;
        p.updateRandom();
        createShape();
    }
    void createShape() {
        shape.setSize(PIXEL);
        shape.setFillColor(ENTITY_COLOR[type]);
    }
    void disable() { shape.setFillColor(sf::Color::Black); }
    void draw(sf::RenderWindow& window) {
        shape.setPosition(p.getx() * PIXEL_SIZE, p.gety() * PIXEL_SIZE);
        window.draw(shape);
    }
    void move(int up, int right) { p.move(up, right); }
};

class Game {
private:
    bool pause = false;
    bool gameOver = false;
    int directionUp = 0;
    int directionRight = 0;
    int scorePoints = 0;
    sf::Text score;
    Point grid[MAX_WIDTH][MAX_HEIGHT];
    std::vector <Entity> snake;
    Entity apple;
public:
    Game() {
        score.setCharacterSize(20);
        score.setFont(FONT);
        score.setFillColor(sf::Color::White);
        score.setPosition(800, 50);
    }
    bool isGameOver() const { return gameOver; }
    void switchPause() { pause = !pause; }
    void setGameOver() {
        gameOver = true;
        score.setFillColor(sf::Color::Red);
    }
    void spawnApple() {
        apple.spawn(1);
    }
    void spawnSnake(bool grow = false) {
        snake.emplace_back();
        snake[snake.size()-1].spawn(0);
        if (grow) {
            Point pGrow = snake[snake.size()-2].getp();
            pGrow.move(-directionUp, -directionRight);
            snake[snake.size()-1].setp(pGrow);
        }
    }
    void setDirection(int up, int right) {
        directionUp = up;
        directionRight = right;
    }
    void update() {
        if (!pause) {
            updateScore();
            updateMovement();
            updateEat();
            updateCollision();
        }
    }
    void updateMovement() {
        for (size_t i = snake.size()-1; i > 0; i--) {
            snake[i].setp(snake[i-1].getp());
        }
        snake[0].move(directionUp, directionRight);
    }
    void updateEat() {
        if (snake[0].getp().compare(apple.getp())) {
            spawnSnake(true);
            spawnApple();
            scorePoints++;
        }
    }
    void updateCollision() {
        Point pHead = snake[0].getp();
        if (pHead.getx() < 1 || pHead.getx() > MAX_WIDTH-2 || pHead.gety() < 1 || pHead.gety() > MAX_HEIGHT-2) {
            setGameOver();
        }
        for (size_t i = 1; i < snake.size(); i++) {
            if (snake[0].getp().compare(snake[i].getp())) {
                break;
            }
        }
    }
    void updateScore() {
        char scoreStr[50];
        sprintf(scoreStr, "SCORE: %d", scorePoints);
        score.setString(scoreStr);
    }
    void draw(sf::RenderWindow& window) {
        window.clear(sf::Color::Black);
        apple.draw(window);
        for (auto& entity : snake) {
            entity.draw(window);
        }
        window.draw(score);
        window.display();
    }
};

int main()
{
    srand(time(NULL));
    
    if (!FONT.loadFromFile("resource/Pixeled.ttf")) { printf("Error loading font!"); }

    sf::RenderWindow window(sf::VideoMode(MAX_WIDTH_SCREEN, MAX_HEIGHT_SCREEN), "Snake", sf::Style::Default, sf::ContextSettings(24,8,4,3,0));
    window.setFramerateLimit(30);
    //window.setVerticalSyncEnabled(true);

    Game game;
    game.spawnApple();
    game.spawnSnake();

    while (window.isOpen()) {
        sf::Event event;
        while (window.pollEvent(event)) {
            if (event.type == sf::Event::Closed) { window.close(); }
            if (sf::Keyboard::isKeyPressed(sf::Keyboard::Escape)) {
                game.switchPause();
                break;
            }
            if (sf::Keyboard::isKeyPressed(sf::Keyboard::Z) || sf::Keyboard::isKeyPressed(sf::Keyboard::Up)) {
                game.setDirection(1, 0);
            }
            else if (sf::Keyboard::isKeyPressed(sf::Keyboard::Q) || sf::Keyboard::isKeyPressed(sf::Keyboard::Left)) {
                game.setDirection(0, -1);
            }
            else if (sf::Keyboard::isKeyPressed(sf::Keyboard::S) || sf::Keyboard::isKeyPressed(sf::Keyboard::Down)) {
                game.setDirection(-1, 0);
            }
            else if (sf::Keyboard::isKeyPressed(sf::Keyboard::D) || sf::Keyboard::isKeyPressed(sf::Keyboard::Right)) {
                game.setDirection(0, 1);
            }
        }
        if (!game.isGameOver()) { game.update(); } 
        game.draw(window);
    }
    return 0;
}
