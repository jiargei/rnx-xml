#!/bin/bash


function get_num_of_stations () {
    echo $(xmllint --valid --xpath "count(//stations/station)" $xml_file)
}

function get_station_name () {
    local i=$1
    echo $(xmllint --valid --xpath "//stations/station[$i]/@StationID" $xml_file | cut -d "=" -f2 | sed "s/\"//g" )
}

function get_year () {
    local i=$1
    local j=$2
    echo $(xmllint --valid --xpath "//stations/station[$i]/year[$j]/@YearID" $xml_file | cut -d "=" -f2 | sed "s/\"//g" )
}

function get_num_of_years () {
    local i=$1
    echo $(xmllint --valid --xpath "count(//stations/station[$i]/year)" $xml_file)
}

function get_num_of_doys () {
    local i=$1
    local j=$2
    echo $(xmllint --valid --xpath "count(//stations/station[$i]/year[$j]/doys)" $xml_file)
}

function get_doys () {
    local i=$1
    local j=$2
    local k=$3
    echo $(xmllint --valid --xpath "//stations/station[$i]/year[$2]/doys[$3]/text()" $xml_file | sed "s/,/ /g" )
}

function are_doys_processed () {
    local i=$1 j=$2 k=$3
    local out=0
    local res=$(xmllint --valid --xpath "//stations/station[$j]/year[$j]/doys[$3]/@processed" $xml_file | cut -d "=" -f2 | sed 's/\"//g')
    if [[ "$res" == "1" ]]; then
        out=1
    fi
    echo $out
}


