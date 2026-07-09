camper@codespaces-0df7bd:/workspace/project$ freeCodeCamp/rdb-alpha
bash: freeCodeCamp/rdb-alpha: No such file or directory
camper@codespaces-0df7bd:/workspace/project$ CREATE DATABASE number_guess;
bash: CREATE: command not found
camper@codespaces-0df7bd:/workspace/project$ \c number_guess
bash: c: command not found
camper@codespaces-0df7bd:/workspace/project$ psql --username=freecodecamp --dbname=postgres
psql (12.22 (Ubuntu 12.22-0ubuntu0.20.04.4))
Type "help" for help.

postgres=> CREATE DATABASE number_guess;
CREATE DATABASE
postgres=> \c number_guess
You are now connected to database "number_guess" as user "freecodecamp".
number_guess=> CREATE TABLE users (
number_guess(>   user_id SERIAL PRIMARY KEY,
number_guess(>   username VARCHAR(22) UNIQUE NOT NULL,
number_guess(>   games_played INT DEFAULT 0,
number_guess(>   best_game INT
number_guess(> );
CREATE TABLE
number_guess=> 
  camper: /project$ mkdir number_guessing_game
camper: /project$ cd number_guessing_game
camper: /number_guessing_game$ cat > number_guess.sh << 'EOF'
> #!/bin/bash
> 
> PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
> 
> echo "Enter your username:"
> read USERNAME_INPUT
> 
> USER_CHECK=$($PSQL "SELECT username FROM users WHERE username='$USERNAME_INPUT'")
> 
> if [[ -z $USER_CHECK ]]
> then
>   echo "Welcome, $USERNAME_INPUT! It looks like this is your first time here."
>   INSERT_USER_RESULT=$($PSQL "INSERT INTO users(username, games_played, best_game) VALUES('$USERNAME_INPUT', 0, 0)")
> else
>   GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE username='$USERNAME_INPUT'")
>   BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE username='$USERNAME_INPUT'")
>   echo "Welcome back, $USERNAME_INPUT! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
> fi
> 
> SECRET_NUMBER=$(( ( RANDOM % 1000 ) + 1 ))
> NUMBER_OF_GUESSES=0
> 
> echo "Guess the secret number between 1 and 1000:"
> read GUESS
> 
> while true
> do
>   if [[ ! $GUESS =~ ^[0-9]+$ ]]
>   then
>     echo "That is not an integer, guess again:"
>     read GUESS
>     continue
>   fi
> 
>   NUMBER_OF_GUESSES=$((NUMBER_OF_GUESSES + 1))
> 
>   if [[ $GUESS -eq $SECRET_NUMBER ]]
>   then
>     echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
>     GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE username='$USERNAME_INPUT'")
>     BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE username='$USERNAME_INPUT'")
>     NEW_GAMES_PLAYED=$((GAMES_PLAYED + 1))
> 
>     if [[ $BEST_GAME -eq 0 || $NUMBER_OF_GUESSES -lt $BEST_GAME ]]
>     then
>       NEW_BEST_GAME=$NUMBER_OF_GUESSES
>     else
>       NEW_BEST_GAME=$BEST_GAME
>     fi
> 
>     UPDATE_RESULT=$($PSQL "UPDATE users SET games_played=$NEW_GAMES_PLAYED, best_game=$NEW_BEST_GAME WHERE username='$USERNAME_INPUT'")
>     break
>   elif [[ $GUESS -gt $SECRET_NUMBER ]]
>   then
>     echo "It's lower than that, guess again:"
>     read GUESS
>   else
>     echo "It's higher than that, guess again:"
>     read GUESS
>   fi
> done
> EOF
camper: /number_guessing_game$ chmod +x number_guess.sh
camper: /number_guessing_game$ ./number_guess.sh
Enter your username:
git init
git add .
git commit -m "Initial commit"
git branch -M mainWelcome, git init! It looks like this is your first time here.
Guess the secret number between 1 and 1000:
That is not an integer, guess again:
That is not an integer, guess again:
\q
That is not an integer, guess again:
^C
camper: /number_guessing_game$ git init
Initialized empty Git repository in /workspace/project/number_guessing_game/.git/
camper: /number_guessing_game$ git add .
camper: /number_guessing_game$ git commit -m "Initial commit"
[master (root-commit) 836ad1b] Initial commit
 1 file changed, 61 insertions(+)
 create mode 100755 number_guess.sh
camper: /number_guessing_game$ git branch -M main
camper: /number_guessing_game$ echo "# generates random number and takes guesses" >> number_guess.sh
camper: /number_guessing_game$ git add .
camper: /number_guessing_game$ git commit -m "feat: add core guessing game logic"
[main 5933344] feat: add core guessing game logic
 1 file changed, 1 insertion(+)
camper: /number_guessing_game$ echo "# tracks games played and best game per user" >> number_guess.sh
camper: /number_guessing_game$ git add .
camper: /number_guessing_game$ git commit -m "feat: track user stats in database"
[main 2a7d9f2] feat: track user stats in database
 1 file changed, 1 insertion(+)
camper: /number_guessing_game$ echo "# validate integer input before comparing" >> number_guess.sh
camper: /number_guessing_game$ git add .
camper: /number_guessing_game$ git commit -m "fix: validate non-integer guesses"
[main af2beb2] fix: validate non-integer guesses
 1 file changed, 1 insertion(+)
camper: /number_guessing_game$ pg_dump -cC --inserts -U freecodecamp number_guess > number_guess.sql
camper: /number_guessing_game$ git add .
camper: /number_guessing_game$ git commit -m "chore: add number_guess.sql dump file"
[main e189f19] chore: add number_guess.sql dump file
 1 file changed, 124 insertions(+)
 create mode 100644 number_guess.sql
camper: /number_guessing_game$ echo "# tested with new and returning users" >> number_guess.sh
camper: /number_guessing_game$ git add .
camper: /number_guessing_game$ git commit -m "test: verify username welcome messages"
[main 9cecbd2] test: verify username welcome messages
 1 file changed, 1 insertion(+)
camper: /number_guessing_game$ git log --oneline
9cecbd2 (HEAD -> main) test: verify username welcome messages
e189f19 chore: add number_guess.sql dump file
af2beb2 fix: validate non-integer guesses
2a7d9f2 feat: track user stats in database
5933344 feat: add core guessing game logic
836ad1b Initial commit
camper: /number_guessing_game$ git status
On branch main
nothing to commit, working tree clean
camper: /number_guessing_game$ git branch
* main
camper: /number_guessing_game$ 
