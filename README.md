# projectY1
## Ystack #Sandeep
Documentation: [Google Docs](https://docs.google.com/document/d/1HNPsUDdQm3ldGrIiTa98CT0sv9WR2pAEpK1n4WT3Qic/edit?usp=sharing)

## Instructions

Launch the project in android studio and execute main.dart on an emulator of version 24 or above.
Open Ystack-1 apk and follow UI instructions

After inputting the data and mobile number, the web user can use the same room key to access this data and concat their 
own values to this data.

Upon submission, an API call to twilio is sent which will then send an sms and whatsapp message to specified
mobile number.

### Flutter Dependencies:
 Firebase, Firestore


To launch the node.js server for the web-end:
Install node.js: https://nodejs.org/en/

```
// Dependencies: 
npm install express
npm install express-formidable

// Execute after changing directories: 
node server.js 

// Open in Browser:
> http://127.0.0.1:8081/

```

### Possible bugs:
In app Notification and Whatsapp message are inconsistant, works sometimes.

End of Docs

