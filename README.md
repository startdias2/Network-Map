# Network-Map
Get a MAP view from a PCAP. 
![netMAP](https://github.com/startdias2/Network-Map/assets/127363682/d5ff6fb2-1351-43d7-9dcf-2918aa0d0521)

1 - Get the Network-Map-main folder file in the CODE button of this site,
If your via CLI use: 
git clone https://github.com/startdias2/Network-Map.git

2 - Open your PCAP with Wireshark and then go to:
Statistics  >  Conversations  >  Select the "IPv4" bar > Click on "Copy" > "CSV".

3 - Create an .csv file with the name:  conversations 
and save the copied information on it
Save this csv file in the Network-Map-main folder.

4 - Run the netmap.sh file and it will open the map as an SVG file automatically on your browser.

Cheers ;-)
