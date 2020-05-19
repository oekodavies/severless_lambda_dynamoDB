# create lambda 
# post
resource "aws_lambda_function" "lambda_test"{
	function_name = "lambda_post"
	filename = "./post.zip/index.js"
	role = "${aws_iam_role.lamda-iam.arn}"
	handler = "index.handler"
	runtime = "nodejs8.10"	
}

resource "aws_api_gateway_resource" "lamda-resource"{
	rest_api_id = "${aws_api_gateway_rest_api.lamda-api-gateway.id}"
	parent_id   = "${aws_api_gateway_rest_api.lamda-api-gateway.root_resource_id}"
	path_part   = "lamda-resource"
}
resource "aws_api_gateway_method" "api-method" {
  rest_api_id   = "${aws_api_gateway_rest_api.lamda-api-gateway.id}"
  resource_id   = "${aws_api_gateway_resource.lamda-resource.id}"
  http_method   = "POST"
  authorization = "NONE"
}

#api gate way invoke lambda (every client post invoke lambda)
resource "aws_api_gateway_integration" "api-invoke-lambda" {
   rest_api_id = "${aws_api_gateway_rest_api.lamda-api-gateway.id}"
   resource_id = "${aws_api_gateway_method.api-method.lamda-resource}"
   http_method = "${aws_api_gateway_method.api-method.http_method}"

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = "${aws_lambda_function.lambda_test.invoke_arn}"
 }
 
 # create an API Gateway "deployment" in order to activate 
 #the configuration and expose the API at a URL 
 resource "aws_api_gateway_deployment" "expose-deployment" {
   depends_on = ["${aws_api_gateway_integration.api-invoke-lambda}"]
   rest_api_id = "${aws_api_gateway_rest_api.lamda-api-gateway.id}"
   stage_name  = "test"
 }
 
 #allowing API Gateway to Access Lambda
 resource "aws_lambda_permission" "api-gw" {
   statement_id  = "AllowAPIGatewayInvoke"
   action        = "lambda:InvokeFunction"
   function_name = "${aws_lambda_function.lambda_test.arn}"
   principal     = "apigateway.amazonaws.com"

   # The "/*/*" portion grants access from any method on any resource
   # within the API Gateway REST API.
   source_arn = "${aws_api_gateway_rest_api.expose-deployment.execution_arn}/*/*"
 }

