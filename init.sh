#!/bin/bash
rm services.yml
value="$(cat inventory.txt)"
count=0
cat compose_header_template.txt>>services.yml
echo "$value" | 
{
    while read -r service_name 
    do
        #Ignores the first line of the services file which is informative
        service_already_installed=$(docker service ls --format "{{.Name}}" | grep -c "$service_name")
        if [ $count -ge 1 ] && [ "$service_already_installed" -eq 0 ]; then 
            printf "    %s:\n" "$service_name">>services.yml
            printf "      image: scratch:latest\n">>services.yml   
        fi 
        count=$((count+1))
    done

    printf "\nInstalling services to prod \n"
    docker stack deploy -c services.yml prod
    printf "\nInstalling services to test \n"
    docker stack deploy -c services.yml test
}