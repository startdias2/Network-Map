# Network Map

![Captura de tela 2024-05-11 172348](https://github.com/startdias2/Network-Map/assets/127363682/98ceb782-3312-4481-94a4-99d72cc77d16)

# Get a MAP view from a PCAP. 

## 1 
Install Graphviz on your machine.

## 2
Get the zip file and extract it, click on the green code button on the top,
If your via CLI use: 
git clone https://github.com/startdias2/Network-Map.git

## 3
Open your PCAP with Wireshark, 
Go to:
Statistics  >  Conversations  >  Select the "IPv4" bar > Click on "Copy" and select "CSV".

## 4
Paste the information inside the conversations.csv file,
you can use excel or nano conversation.csv

## 5
Run the netmap.sh file and it will open the map as an SVG file automatically on your browser.

To change the map for a new one just change the information inside the conversation.csv file 

Cheers ;-)
