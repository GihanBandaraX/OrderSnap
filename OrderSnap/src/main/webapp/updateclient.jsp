<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Update Client</title>
    
    <!-- Include Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="header&footer.css">
    
  
    <style>
        body {
            background-color: #f2f2f2;
        }
        
        .form-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>



			<% 
			String id=request.getParameter("id");
			String name=request.getParameter("name");
			String gender=request.getParameter("gender");
			String dob=request.getParameter("dob");
			String email=request.getParameter("email");
			String phone=request.getParameter("phone");
			String address=request.getParameter("address");
			String username=request.getParameter("username");
			String password=request.getParameter("password");
			
			%>
			
			
			
			
				 <header class="header">
       
        <!-- Brand and Slogan-->
        <div class="header-left" style="margin-right: 25px;">
          <!-- Logo-->
        <a href="#default"><img src="mainLogo.png" alt="MyPlanner Image" class="logo" id="headlogo" height="100px" width="100px" ></a>
        
        </div>

        <div class="navbar" id="Topnav">
          <a href="#default"><button class="active" type="button" id="bttn1"><b>Home</b></button></a>
          <div class="dropdown">
            <button class="dropbtn">Services</button>
            <div class="dropdown-content">
              <a href="#">Awards</a>
              <a href="#">Candidates</a>
              <a href="#">About Award Ceremony</a>
              <a href="#">Nomination Result</a>
              <a href="#">Sponsors</a>
            </div>
          </div>
          <a href="#contact"><button  type="button" id="bttn1">Gallery</button></a>
          <a href="#contact"><button  type="button" id="bttn1">Contact Us</button></a>
          <a href="#about"><button  type="button" id="bttn1">About Us</button></a>
          <!--<a href="javascript:void(0);" class="icon" onclick="myFunction()">&#9776;</a>-->
        </div>
        <div class="search">
          <form action="/search" method="get">
            <img src="search.png" class="searchimg" height="20px" width="20px">
            <input type="text" class ="input" name="search data" placeholder="Find here" />
            <input type="submit"id="searchbtn" value="Search">
          </form>
        </div>
        <!--User button with photo-->
        <div class="userbtn">
          <div class="userbtntext"><a href="#login" class="userlink">Login/SignUp</a></div>
          <img src="uuser.png" class="userbtnimg" height="35px" width="35px">
        </div>
        
      </header>
    
       
			
			
			
    <div class="container d-flex align-items-center justify-content-center" style="min-height: 100vh;">
        <div class="form-container col-md-6">
            <h2 class="text-center">Update Profile</h2>
            <form action="updateclient" method="post">
                <div class="form-group">
                    <label for="id">Client ID:</label>
                    <input type="text" class="form-control" id="id" name="id" value="<%=id%>" readonly>
                </div>
                <div class="form-group">
                    <label for="name">Name:</label>
                    <input type="text" class="form-control" id="name" name="name" value="<%=name%>">
                </div>
                <div class="form-group">
                    <label for="gender">Gender:</label>
                    <div class="form-check">
                        <input type="radio" class="form-check-input" id="genderMale" name="gender" value="Male" required>
                        <label class="form-check-label" for="genderMale">Male</label>
                    </div>
                    <div class="form-check">
                        <input type="radio" class="form-check-input" id="genderFemale" name="gender" value="Female" required>
                        <label class="form-check-label" for="genderFemale">Female</label>
                    </div>
                </div>
                <div class="form-group">
                    <label for="dob">Date of Birth (MM-DD-YYYY):</label>
                    <input type="date" class="form-control" id="dob" name="dob" pattern="\d{4}-\d{2}-\d{2}" placeholder="YYYY-MM-DD" value="<%=dob%>">
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" class="form-control" id="email" name="email" value="<%=email%>">
                </div>
                <div class="form-group">
                    <label for="phone">Phone:</label>
                    <input type="tel" class="form-control" id="phone" name="phone" value="<%=phone%>">
                </div>
                <div class="form-group">
                    <label for="address">Address:</label>
                    <input type="text" class="form-control" id="address" name="address" size="40" value="<%=address%>">
                </div>
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" class="form-control" id="username" name="username" value="<%=username%>">
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" class="form-control" id="password" name="password" value="<%=password%>">
                </div>
                <button type="submit" class="btn btn-primary">Update</button>
            </form>
        </div>
    </div>
    
    
      <hr style="background-color: black;height:1px;">
    <footer>
      <div class="footer-container">
       
          <div class="footerhead1">
            <img src="mainLogo1.png" alt="logo" class="logo" id="footlogo" height="150px" width="150px" > 
            <p id="footerhead1des">We offer customized event planning services <br>tailored to your specific needs.</p>
            <div>
              <a href="#"><img src="fb.png" class="fimg"></a>
                <a href="#"><img src="instagram.png" class="fimg"></a>
                <a href="#"><img src="twitter.png" class="fimg"></a>
                
            </div>
          </div>
          <div class="footerhead" id="fhd2">
            <h2>For Customers</h2>
            <a href="#">Events</a>
                <a href="#">Consulting</a>
                <a href="#">Plan Events</a>
                <a href="#">Booking Venues</a>
                <a href="#">Reserve Services</a>
                
          </div>
          <div class="footerhead" id="fhd3">
            <h2>For Vendors</h2>
              <a href="#">Advertisement</a>
              <a href="#">Service info</a>
              <a href="#">Recomendation</a>
              <a href="#">Why should join</a>
          </div>
          <div class="footerhead" id="fhd4">
            <h2>We are</h2>
              <a href="#">About Us</a>
              <a href="#">Contact Us</a>
              <a href="#">What is Event Planing?</a>
          </div>
          
        
        <div class="footer-email">
            <h2>Connect with Us</h2>
             <button type="button" onclick="" Value="BOOK CONSULTATION" id="footerc-btn">BOOK CONSULTATION</button>
        </div>
      </div>
      <center>
        <div class="copyright"><h4>© 2023 MyPlanner. All rights reserved.</h4></div>
      </center>
      
     </footer>
    
</body>
</html>
