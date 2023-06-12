// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

string tempvar = 'Enter_your_name_here';
System.debug('Hello World!');
System.debug('My name is ' + tempvar);

//1 HTTP GET METHOD
Http http = new Http();
HttpRequest request = new HttpRequest();
request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
request.setMethod('GET');
HttpResponse response = http.send(request);
// If the request is successful, parse the JSON response.
if(response.getStatusCode() == 200) {
    // Deserialize the JSON string into collections of primitive data types.
    Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
    // Cast the values in the 'animals' key as a list
    List<Object> animals = (List<Object>) results.get('animals');
    System.debug('Received the following animals:');
    for(Object animal: animals) {
        System.debug(animal);
    }
}

//2 HTTP POST METHOD
Http http = new Http();
HttpRequest request = new HttpRequest();
request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
request.setMethod('POST');
request.setHeader('Content-Type', 'application/json;charset=UTF-8');
// Set the body as a JSON object
request.setBody('{"name":"mighty moose"}');
HttpResponse response = http.send(request);
// Parse the JSON response
if(response.getStatusCode() != 201) {
    System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getStatus());
} else {
    System.debug(response.getBody());
}

//3  SOAP CALLOUT
calculatorServices.CalculatorImplPort calculator = new  calculatorServices.CalculatorImplPort();
Double x = 1.0;
Double y = 2.0;
Double result = calculator.doAdd(x,y);
System.debug(result);

//4 EXPOSE AS REST WEB SERVICE (SKELETON ONLY)
@RestResource(urlMapping='/Account/*')
global with sharing class MyRestResource {
    @HttpGet
    global static Account getRecord() {
        // Add your code
    }
}

//5. RETRIEVE SESSION ID FROM SETUP, AND CREATE A RECORD FROM CURL, RUN IN TERMINAL
curl -v https://login.salesforce.com/services/oauth2/token -d "grant_type=password" -d "client_id=<your_consumer_key>" -d "client_secret=<your_consumer_secret>" -d "username=<your_username>" -d "password=<your_password_and_security_token>" -H "X-PrettyPrint:1"
curl https://yourInstance.my.salesforce.com/services/apexrest/Cases/<Record_ID> -H "Authorization: Bearer <your_session_id>" -H "X-PrettyPrint:1"

// SF to SF demo
//Add a new Account
AccountWebService.NewAccountRequestWrapper newAccount = new AccountWebService.NewAccountRequestWrapper();
newAccount.name = 'TestAccount2';
newAccount.phone = '123456789';
//AccountWebService.addAccount(newAccount);
//get Account details based on Id
AccountWebService.getAccount('0012w00001bIcCTAA0');
//delete Account based on Id
AccountWebService.deleteAccount('12121212');

//JSON format example
{
  "subject" : "Bigfoot Sighting!",
  "status" : "New",
  "origin" : "Phone",
  "priority" : "Low"
}