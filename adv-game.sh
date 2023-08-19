#!/bin/bash

player_health=200
player_gold=0

echo "Welcome to the Adventure Game!"

while true; do
    echo "1. Explore"
    echo "2. Visit Store"
    echo "3. Quit"
    read -p "Choose an option: " choice

    case $choice in
        1)
            echo "You venture into the forest..."
            enemy_health=$(( (RANDOM % 50) + 50 ))

            while (( enemy_health > 0 )); do
                echo "An enemy appears! Health: $enemy_health"
                read -p "Attack (a) / Run (r): " action

                if [[ "$action" == "a" ]]; then
                    player_damage=$(( (RANDOM % 20) + 10 ))
                    enemy_health=$((enemy_health - player_damage))
                    echo "You dealt $player_damage damage!"
                elif [[ "$action" == "r" ]]; then
                    echo "You managed to escape."
                    break
                fi

                if (( enemy_health > 0 )); then
                    enemy_damage=$(( (RANDOM % 15) + 5 ))
                    player_health=$((player_health - enemy_damage))
                    echo "The enemy dealt $enemy_damage damage!"
                    if (( player_health <= 0 )); then
                        echo "You have been defeated..."
                        exit
                    fi
                else
                    echo "You defeated the enemy!"
                    player_gold=$((player_gold + 20))
                    echo "You gained 20 gold."
                fi
            done
            ;;
        2)
            echo "Welcome to the Store!"
            echo "1. Buy Health Potion (30 gold)"
            echo "2. Buy Armor (50 gold)"
            read -p "Choose an option: " store_choice

            case $store_choice in
                1)
                    if (( player_gold >= 30 )); then
                        player_health=$((player_health + 20))
                        player_gold=$((player_gold - 30))
                        echo "You bought a health potion and restored 20 health."
                    else
                        echo "Not enough gold."
                    fi
                    ;;
                2)
                    if (( player_gold >= 50 )); then
                        player_health=$((player_health + 10))
                        player_gold=$((player_gold - 50))
                        echo "You bought armor and gained 10 health."
                    else
                        echo "Not enough gold."
                    fi
                    ;;
            esac
            ;;
        3)
            echo "Thanks for playing!"
            exit
            ;;
    esac
done
