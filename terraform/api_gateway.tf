#create an aws api
resouce "aws_api_gateway_rest_api" "lamda-api-gateway"{
	name= "lamda-api"
	description = "api access to lamda"
}
