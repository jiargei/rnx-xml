#!/bin/bash


xml_file=${1-sample.xml}
source ./xml_functions.sh

ns=$(get_num_of_stations)

if [[ "$ns" == "" ]] || [ $ns -lt 1 ]; then
    echo "No valid Station in XML"
    exit 
fi

for (( i=1; i<=$ns; i++ )) ; do
    station=$(get_station_name $i)
    echo "---------------------------------------------------- $station --"
    ny=$(get_num_of_years $i)

    if [[ "$ny" == "" ]] || [ $ny -lt 1 ]; then
        echo "No valid Year in Station"
        continue
    fi

    for (( j=1; j<=$ny; j++ )) ; do
        year=$(get_year $i $j)
        echo "Processing Station: $station, Year: $year"
        nd=$(get_num_of_doys $i $j)

        if [[ "$nd" == "" ]] || [ $nd -lt 1 ]; then
            echo "No valid doys in year"
            continue
            # exit
        fi
        
        for (( k=1; k<=$nd; k++ )) ; do

            doys=$(get_doys $i $j $k)
            echo "are_doys_processed: $(are_doys_processed $i $j $k)"
            
            if [ $(are_doys_processed $i $j $k) -eq 1 ]; then
                echo "Allready processed: Station: $station, Year: $year, DOYs: $doys"
                continue
            fi

            echo "Processing Station: $station, Year: $year, DOYs: $doys" 

            for doy in $doys; do
                echo "Run 'copy01sec.sh $doy $year $station'"
            done

        done

    done

done
