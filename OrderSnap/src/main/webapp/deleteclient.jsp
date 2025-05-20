<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Delete Account</title>
    <!-- Add Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        
        body {
            background-color: #f5f5f5;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
        }
        h1 {
            font-size: 24px;
            text-align: center;
        }
        label {
            font-size: 18px;
        }
    </style>
</head>
<body>
	<% 
	String id=request.getParameter("id");
	String name=request.getParameter("name");
	String email=request.getParameter("email");
	String phone=request.getParameter("phone");
	String username=request.getParameter("username");


	%>
	


    <div class="container">
        <h1>Delete Account</h1>
        <form action="deleteclient" method="post">
            <div class="form-group">
                <label for="id">Client ID:</label>
                <input type="text" class="form-control" id="id" name="id" value="<%=id%>" readonly>
            </div>
            
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" class="form-control" id="name" name="name" value="<%=name%>" readonly>
            </div>
    
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" class="form-control" id="email" name="email" value="<%=email%>" readonly>
            </div>
    
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" class="form-control" id="username" name="username" value="<%=username%>" readonly>
            </div>
    
            <button type="submit" class="btn btn-danger">Delete Account</button>
        </form>
    </div>

    <!-- Add Bootstrap JS if needed -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
