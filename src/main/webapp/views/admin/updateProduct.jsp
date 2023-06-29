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
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js"
	integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/views/css/style.css">
<script src="https://kit.fontawesome.com/999051c9de.js"
	crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
	<jsp:include page="../common/_header.jsp"></jsp:include>
	<c:if test="${not empty message}">
		<input type="hidden" id="message" value="${message }">
		<input type="hidden" id="type" value="${type }">
	</c:if>
	<div class="container">
		<h1>Sửa sản phẩm</h1>
		<f:form
			action="${pageContext.request.contextPath}/admin/update"
			method="post" enctype="multipart/form-data" modelAttribute="data">

			<f:input type="hidden" name="id" path="id" value="${p.id }" />
			<div class="form-group">
				<label for="exampleFormControlFile1"> Ảnh Sản Phẩm *:</label> <input
					type="file" class="form-control-file" id="fileUpload" name="file" />
			</div>
			<label for="exampleInputEmail1">Tên Sản Phẩm* :</label>
			<f:input type="text" class="form-control" name="tieude"
				id="exampleInputEmail1" placeholder="Nhập tên sản phẩm"
				path="tieude" value="${p.tieuDe }" />
				<f:errors style="color:red" path="tieude" element="div"></f:errors>
			<label for="exampleInputEmail1">Giá Sản Phẩm</label>
			<f:input type="number" class="form-control" id="exampleInputEmail1"
				placeholder="Nhập giá bán sản phẩm" name="gia" path="gia"
				value="${p.gia }" />
				<f:errors style="color:red" path="gia" element="div"></f:errors>
			<label for="exampleInputEmail1">Giảm Giá (%)</label>
			<f:input type="number" class="form-control" id="exampleInputEmail1"
				placeholder="Nhập % giảm giá cho sản phẩm" name="giamgia"
				path="giamgia" value="${p.giamGia }" />
				<f:errors style="color:red" path="giamgia" element="div"></f:errors>
			<label for="exampleInputEmail1">Phân Loại *</label>
			<f:select class="form-control" id="exampleFormControlSelect1"
				name="phanloai" path="phanloai">
				<c:forEach items="${listCategory }" var="c">
					<option value="${c.id }"
						${c.id ==  p.category.id ? 'selected="selected"' : ''}>${c.ten }</option>
				</c:forEach>


			</f:select>

			<label for="exampleInputEmail1">Số lượng Size *</label>
			<br>


			<c:forEach items="${listKichThuoc }" var="kt">
				<label style="padding-left: 5px">${kt.kichThuoc.tenKichThuoc }</label>
				<input style="width: 50px" type="number"
					name="${kt.kichThuoc.tenKichThuoc }" value="${kt.soLuong}">
			</c:forEach>


			<br>
			<label for="exampleInputEmail1">Mô Tả Sản Phẩm* :</label>
			<f:input type="text" class="form-control" id="exampleInputEmail1"
				placeholder="Nhập mô tả sản phẩm" name="mota" path="mota"
				value="${p.moTa }" />
				<f:errors style="color:red" path="mota" element="div"></f:errors>
			<label for="exampleInputEmail1">Chất Liệu Sản Phẩm* :</label>
			<f:input type="text" class="form-control" id="exampleInputEmail1"
				placeholder="Nhập chất liệu sản phẩm" name="chatlieu"
				path="chatlieu" value="${p.chatLieu }" />
				<f:errors style="color:red" path="chatlieu" element="div"></f:errors>
			<label for="exampleInputEmail1">Thiết kế Sản Phẩm* :</label>
			<f:input type="text" class="form-control" id="exampleInputEmail1"
				placeholder="Nhập thiết kế sản phẩm" name="thietke" path="thietke"
				value="${p.thietKe }" />
				<f:errors style="color:red" path="thietke" element="div"></f:errors>
			<br>
			<button type="submit" class="btn btn-danger">
				<i class="fa-solid fa-plus"></i> Sửa Sản Phẩm
			</button>

		</f:form>
	</div>
	<br>

	<jsp:include page="../common/_footer.jsp"></jsp:include>
			<script type="text/javascript">
		var message = document.getElementById("message").value;
		var type = document.getElementById("type").value;
		if(message != ""){
			console.log("ggk");
			Swal.fire(message, '', type);
		}
		
</script>
</body>
</html>