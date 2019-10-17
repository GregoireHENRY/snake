printf "== SNAKE builder ==\n\n"

printf "Installing SFML\n"
sudo apt-get install libsfml-dev
printf "\n"

printf "Initializing folders\n"
printf "0" > resource/HighestScore.txt
printf "\n"

printf "Compiling\n"
make
printf "\n"

printf "Installation completed succesfully!\n"
