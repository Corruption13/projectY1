// Twilio Credentials
var accountSid = 'ACCOUNT SID';
var authToken = 'ACCOUNT TOKEN';

//require the Twilio module and create a REST client
var client = require('twilio')(accountSid, authToken);

function sendSms(callback) {
    client.messages.create({
        to: 'TO',
        from: 'FROM',
        body: 'Message sent from Twilio!',
    }, callback);
}

// Export this function as a node module so that you can require it elsewhere
module.exports = sendSms;