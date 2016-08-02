#!/bin/bash

chr() {
  printf \\$(printf '%03o' $1)
}
 
ord() {
  printf '%d' "'$1"
}

echo ""
echo "Running Secret Message Telep"
echo ""
echo "You want to encode the message or decode the message?"
echo "To Encode/Decode press 'en/de' :"
read -r mode
echo "Please Enter your message here:"
read -r message
 
if [ "$mode" == "en" ]
then
        echo "Encoding..."
        z=0
        plus=""
        for (( i=0; i<${#message}; i++ ));
        do
                indChar="${message:$i:1}"
                asciiIndChar=$(ord "$indChar")
                if [ "$asciiIndChar" -gt "$z" ]
                then
                        for(( j=asciiIndChar; j>z; j-- ));
                        do
                                plus+="+"
                        done
                plus+="."
                else
                        for(( j=asciiIndChar; j<z; j++ ));
                        do
                                plus+="-"
                        done
                plus+="."
                fi
                z="$asciiIndChar"
        done
        echo "Encoded Message below(Copy and Forward):"
        echo ""
        echo "$plus"
        echo ""
        echo "Encoding Done"
        echo "$plus" > encode.txt
else
        echo "Decoding..."
        count=0
        dec=""
        for (( k=0; k<${#message}; k++ ));
        do
                
                indChar="${message:$k:1}"
                if [ "$indChar" == "+" ]
                then
                        count=$(( $count + 1 ))
                elif [ "$indChar" == "-" ]
                then
                        count=$(( $count - 1 ))
                elif [ "$indChar" == "." ]
                then
                        asciiIndChar=$(chr "$count")
                        dec+="$asciiIndChar"
                else
                        count=$(( $count - 0 ))
                fi
        done
        echo "Decoded Message below(Keep it Safe):"
        echo ""
        echo "$dec"
        echo ""
        echo "Decoding Done"
        echo "$dec" > decode.txt
fi