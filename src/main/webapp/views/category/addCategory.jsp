<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/views/css/style.css">
    <script src="https://kit.fontawesome.com/999051c9de.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>

<jsp:include page="../common/_header.jsp"></jsp:include>
<div class="container">
    <h1>Thêm Category mới</h1>
    <p style="color: red">${message }</p>
    <f:form action="${pageContext.request.contextPath}/category/add" method="post" modelAttribute="data" enctype="multipart/form-data">
 
   <label for="exampleInputEmail1">Tên Category * :</label>
    <f:input type="text" class="form-control"  id="exampleInputEmail1" placeholder="Nhập tên category " name="ten" path="ten"/>
    <f:errors style="color:red" path="ten" element="div"></f:errors>
      <br>
      <button type="submit" class="btn btn-danger"><i class="fa-solid fa-plus"></i> Thêm Category</button>
  

              </f:form>
        </div>
<br>
<jsp:include page="../common/_footer.jsp"></jsp:include>
</body>
</html>