console.log('function starts')

const AWS = require('aws-sdk')
AWS.config.apiVersions = {
  dynamodb: '2012-08-10',
  // other service API versions
  region: 'eu-west-1'
};
const dynamodb = new AWS.DynamoDB.DocumentClient()

exports.handler = async(event, context) =>{
	const feedbackitem = {};
	
	feedbackitem.Item = {      
    "email": event.email,      
    "fname": event.fname,
	"lname": event.lname,
	"country": event.country,
    "message": event.message    
  };
	feedbackitem.TableName: "mywebsite";
  
  try
	{
	 const data = dynamodb.put(feedbackitem).promise();  
	 console.log(data);
	}
  catch(err)
	{
	  console.log(err);
	} 
	
	
}