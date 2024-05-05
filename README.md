# Network-Map (NetMap)
![netMAP](https://github.com/startdias2/Network-Map/assets/127363682/d5ff6fb2-1351-43d7-9dcf-2918aa0d0521)

# Get a MAP view from a PCAP. 

## 1 
Get the zip file in the CODE button and Unzip it.
If your via CLI use: 
git clone https://github.com/startdias2/Network-Map.git

## 2
Open your PCAP with Wireshark, 
Go to:
Statistics  >  Conversations  >  Select the "IPv4" bar > Click on "Copy" and slect "CSV".

## 3 
Paste the information inside the conversations.csv file,
you can use excel or nano conversation.csv

## 4 
Run the netmap.sh file and it will open the map as an SVG file automatically on your browser.

To change the map for a new one just change the information inside the conversation.csv file 

Cheers ;-)
