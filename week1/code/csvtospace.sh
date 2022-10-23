#Firstly, create a csv file with 'code "echo -e "test, test"" >> ../sandbox/practest.csv'
echo "creating sapce based separeted version of $1"
cat $1 | tr -s "," " " >> $1.txt
echo "Done!"
exit

#Then run 
bash csvtospace.sh ../sandbox/practest.csv



#For csv files in Temperature directory, they need to be downloaded first:


cd ../sandbox
wget https://raw.githubusercontent.com/mhasoba/TheMulQuaBio/master/content/data/Temperatures/1800.csv (1801,1802,1803 etc.)

#Back to code directory:
cd ../code
bash csvtospace.sh ../sandbox/1800.csv (same to other 3 files)
bash csvtospace.sh ../sandbox/1801.csv
bash csvtospace.sh ../sandbox/1802.csv
bash csvtospace.sh ../sandbox/1803.csv