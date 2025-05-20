<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Client Details</title>
    <!-- Add Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="header&footer.css">
    <style>
        
        table {
            width: 100%;
            max-width: 800px; 
            margin: 0 auto;
            font-size: 20px; 
        }
    </style>
</head>
<body class="text-center">

<% String successMessage = (String) request.getAttribute("successMessage"); %>
<% String unsuccessMessage = (String) request.getAttribute("unsuccessMessage"); %>

<% if (successMessage != null) { %>
    <script>
        alert("<%= successMessage %>");
    </script>
<% } %>

<% if (unsuccessMessage != null) { %>
    <script>
        alert("Error: <%= unsuccessMessage %>");
    </script>
<% } %>



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


<div class="container">
    <table class="table table-striped table-bordered">
        <c:forEach var="client" items="${clientDetails}">
            <tr>
                <th>ID</th>
                <td>${client.id}</td>
            </tr>
            <tr>
                <th>Name</th>
                <td>${client.name}</td>
            </tr>
            <tr>
                <th>Gender</th>
                <td>${client.gender}</td>
            </tr>
            <tr>
                <th>Date of Birth</th>
                <td>${client.dob}</td>
            </tr>
            <tr>
                <th>Email</th>
                <td>${client.email}</td>
            </tr>
            <tr>
                <th>Phone</th>
                <td>${client.phone}</td>
            </tr>
            <tr>
                <th>Address</th>
                <td>${client.address}</td>
            </tr>
            <tr>
                <th>Username</th>
                <td>${client.username}</td>
            </tr>
            <tr>
                <td colspan="2" class="text-center">
                    <c:url value="updateclient.jsp" var="clientupdate">
                        <c:param name="id" value="${client.id}"/>
                        <c:param name="name" value="${client.name}"/>
                        <c:param name="gender" value="${client.gender}"/>
                        <c:param name="dob" value="${client.dob}"/>
                        <c:param name="email" value="${client.email}"/>
                        <c:param name="phone" value="${client.phone}"/>
                        <c:param name="address" value="${client.address}"/>
                        <c:param name="username" value="${client.username}"/>
                        <c:param name="password" value="${client.password}"/>
                    </c:url>
                    <a href="${clientupdate}" class="btn btn-primary">Update</a>

                    <c:url value="deleteclient.jsp" var="clientdelete">
                        <c:param name="id" value="${client.id}"/>
                        <c:param name="name" value="${client.name}"/>
                        <c:param name="gender" value="${client.gender}"/>
                        <c:param name="dob" value="${client.dob}"/>
                        <c:param name="email" value="${client.email}"/>
                        <c:param name="phone" value="${client.phone}"/>
                        <c:param name="address" value="${client.address}"/>
                        <c:param name="username" value="${client.username}"/>
                        <c:param name="password" value="${client.password}"/>
                    </c:url>
                    <a href="${clientdelete}" class="btn btn-danger">Delete</a>
                </td>
            </tr>
        </c:forEach>
    </table>
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


<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
