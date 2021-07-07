STEPS ON PUBLISHING TO SERVER

SERVER = 172.25.116.81


1) BACKUP the files from the server ddctr folder( SERVER )
2) Go to local project directory
3) Copy all files excluding the ff:
	*Database file
	*web.config
	*font-awesome-4.7.0 folder
	*moment.js folder
	*jquery folder
	*csv folder
4) Paste to server ddctrl folder( SERVER )
5) On export_csv.aspx change the variable wtf to
	"C:\inetpub\wwwroot\ddctrl\csv\falp_duedate.csv"

	from the script change the variable wtf to 
	"http://172.25.112.171:8090/csv/falp_duedate.csv"

6) On export_csv_problem.aspx change the variable wtf to
	"C:\inetpub\wwwroot\ddctrl\csv\falp_duedate_problem.csv"

	from the script change the variable wtf to 
	"http://172.25.112.171:8090/csv/falp_duedate_problem.csv"

7) Added suzuki
	-Default.aspx
	-addStd.aspx
	-nkproblemlist.aspx
	-nkratio.aspx