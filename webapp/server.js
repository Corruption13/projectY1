// Replace all ###Variables with your own Twilio API keys.

var express = require('express');
var formidable = require('express-formidable');

var app = express();
app.use(formidable());

app.get('/', function (req, res) {
   res.sendfile('web.html');
})


app.post('/', function(req, res) {
  console.log(req.fields);
  res.send(req.fields["output"]);
  sms(req.fields["mobile"], req.fields["output"], req.fields["key"])
});
var server = app.listen(8081, function () {
   var host = server.address().address
   var port = server.address().port
   
   console.log("Example app listening at http://%s:%s", host, port)
})






var sms = function twilioSMS(mobile, output, key){
    console.log("SMS to ", mobile);
    // Twilio Credentials
    var accountSid = '###YourSiD';
    var authToken = "###YourAUTH";
    if (mobile[0]!= "+"){
        mobile = "+91"+mobile;
    }
    //require the Twilio module and create a REST client
    var client = require('twilio')(accountSid, authToken);
    var client2 = require('twilio')(accountSid, authToken);
    console.log("debug 1");
    function sendSms(callback) {
        console.log("starting");
        client.messages.create({
            to: mobile,
            from: "+###YourNumber",
            body: "The output is: " + output,
        }, callback);
        console.log("sms sent");
        client2.messages.create({
            to: "whatsapp:"+mobile,
            from: "whatsapp:"+ "###YourNumber",
            body: "The output is: " + output,
        }, callback);
        
        console.log("whatsapp sent.\nending");

        
    }
    sendSms();

}
