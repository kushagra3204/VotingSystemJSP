<%-- 
    Document   : voter
    Created on : 24-Oct-2023, 3:37:38 am
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Vote</title>
        
<style>
        body {
            font-family: Arial, sans-serif;
            background-color: #3498db;
            text-align: center;
            color: #fff;
        }

        .container {
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            padding: 20px;
            max-width: 300px;
            margin: 0 auto;
        }

        h1 {
            color: #333;
        }

        .voter-info {
            margin-top: 20px;
        }

        label {
            color: #3498db;
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }

        .voter-info p {
            font-size: 18px;
            margin: 0;
            color: #3498db; /* Blue color for text */
        }
        #name, #voterId {
            color: #3498db;   
        }
        .candidates label {
            display: block;
            margin-bottom: 10px;
        }

        .candidates input[type="radio"] {
            margin-right: 5px;
        }
        .candidate-details{
            color: #3498db;
        }
    </style>
</head>
    <body>
        <%
   response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
   response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
   response.setDateHeader("Expires", 0); // Proxies.
%>
        <c:out value="${sessionScope.voter_id}"></c:out>
        <c:if test="${voter_id eq 0}">
            <c:redirect url="index.html"></c:redirect>
        </c:if>
        <c:set var="name" value="${sessionScope.voter_name}"></c:set>
        <c:set var="voterid" value="${sessionScope.voter_id}"></c:set>
       <div class="container">
        <h1>Voter Information</h1>
        <div class="voter-info">
            <label for="name" style="display: inline-block;">Name:</label>
            <p id="name">${name}</p>
            <label for="voterId" style="display: inline-block;">Voter ID:</label>
            <p id="voterId">${voterid}</p>
        </div>
        
<!--        <div class="candidate-details">
            <h1>Candidate Information</h1>
            <p>Candidate 1 - Party A</p>
            <p>Candidate 2 - Party B</p>
        </div>
        -->
        <sql:setDataSource 
        var="con" driver="com.mysql.jdbc.Driver" 
         url="jdbc:mysql://localhost/voting_system" user="root" password="Password67*"/>
       
        <sql:query dataSource="${con}" var="result">
            Select * from candidate;
        </sql:query>  
            <h1>Candidate Information</h1>
            <div class="candidate-details">
         <c:forEach var = "row" items = "${result.rows}">
           <p>Candidate : ${row.name} - Party ${row.party}</p>
         </c:forEach>
            </div>
        <h1>Vote for a Candidate</h1>
        <form method="post" action="processVote.jsp">
            <div class="candidates">
                <label>
                    <input type="radio" name="candidate" value="Bjp"> BJP
                </label>
                <label>
                    <input type="radio" name="candidate" value="Congress"> Congress
                </label>
            </div>
            <input type="submit" value="Vote">
        </form>
    </div>
        
    </body>
</html>