function sendJSON(){ 
               
			let fname = document.querySelector('#fname').value; 
			let lname = document.querySelector('#lname').value;
            let email = document.querySelector('#email').value;
			let country = document.querySelector('#country').value; 
			let feedback = document.querySelector('#subject').value;
            
			//alert("hi " + fname)
			
			const url = "https://kfb9dlbm36.execute-api.us-west-2.amazonaws.com/prod/vote"
          
              // Converting JSON data to string 
			var data = JSON.stringify({ "name": fname, "name":lname, "email": email, "country": country, "feedback": feedback }); 
			
			// print jason data
			//alert(data)
			console.log(JSON.stringify(data))
  
            // Sending data with the request 
            //xhr.send(data); 
        } 