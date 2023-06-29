<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>HanLuxury</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath }/views/css/style.css">
      <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://kit.fontawesome.com/999051c9de.js" crossorigin="anonymous"></script>
</head>
<body>
<jsp:include page="common/_header.jsp"></jsp:include>
 <c:if test="${not empty message}">
   						<input type="hidden" id="message" value="${message }">
                        <input type="hidden" id="type" value="${type }">
						</c:if>
 		<c:if test="${account == null}">
      <h3> Bạn không có quyền truy cập chức năng này</h3>
      </c:if>
      <c:if test="${account != null }">
      <div class="container" >
        <input type="hidden" value="${account.username }" name="userGH">
        <c:out value="${sessionScope.userGH}"/>
       
    <h1 class="giua"><i class="fa-solid fa-cart-shopping"></i> Giỏ Hàng</h1>
    <br>
    <div class="row">
    <div class="col-md-9">
    <div class="giohang">
        <table class="table">
            <thead>
              <tr>
                <th scope="col" colspan="5.5">Tên sản phẩm</th></div>
                <th scope="col" colspan="1">Size</th>
                <th scope="col" colspan="1">Đơn giá</th>
                <th scope="col" colspan="1">Số lượng</th>
                <th scope="col" colspan="1">Thành tiền</th>
                <th scope="col" colspan="1"></th>
              </tr>
            </thead>
            <tbody>
             <c:if test="${fn:length(listCart) == 0}">
            <tr>
            <td> Không có sản phẩm nào<td>
            </tr>
             </c:if>
             <c:if test="${fn:length(listCart) > 0}">
              <c:forEach items="${listCart }" var="p">
               <tr>
                <th colspan="5.5"><div class="cart-img"><img src="${pageContext.request.contextPath}/views/img/${p.product.anh }"> ${p.product.tieuDe } </div></th>
                <td colspan="1"> ${p.kichThuoc }</td>
                <td colspan="1"><fmt:formatNumber>${p.donGia }</fmt:formatNumber></td>
                <td colspan="1"><span><a style="color:red;" href="${pageContext.request.contextPath }/cart/giam?id=${p.product.id }&kichThuoc=${p.kichThuoc}"><i class="fa-solid fa-minus"></i></a></span> <span>${p.soLuong }</span> <span ><a style="color:green;" href="${pageContext.request.contextPath }/cart/them?id=${p.product.id }&kichThuoc=${p.kichThuoc}"><i class="fa-solid fa-plus"></i></a></span></td>
                <td colspan="1"><fmt:formatNumber>${p.soLuong * p.donGia }</fmt:formatNumber></td>
                <td class="xoa" colspan="1"><a style="color: black" href="${pageContext.request.contextPath}/cart/delete?id=${p.product.id }&kichThuoc=${p.kichThuoc}"><i class="fa-solid fa-trash"></i></a></td>
              </tr>
              
              </c:forEach>
             </c:if>
            </tbody>
          </table>
    </div>
    </div>
    <div class="col-md-3">
     <div style="height: 100% ; width: 100%"><h4> Thông tin giao hàng</h4>
  <f:form action="${pageContext.request.contextPath }/cart/thanhtoan" method="post" modelAttribute="data">
   <label for="exampleInputEmail1">Tên người nhận * :</label>
    <f:input type="text" class="form-control" name="tennguoinhan" id="exampleInputEmail1" placeholder="Nhập tên người nhận" path="tenNguoiNhan"/>
     <f:errors style="color:red" path="tenNguoiNhan" element="div"></f:errors>
     <label for="exampleInputEmail1">Số điện thoại người nhận * :</label>
    <f:input type="number" class="form-control" name="sdtnguoinhan" id="exampleInputEmail1" placeholder="Nhập sđt người nhận" path="sdtNguoiNhan"/>
     <f:errors style="color:red" path="sdtNguoiNhan" element="div"></f:errors>
      <label for="exampleInputEmail1">Địa chỉ giao hàng * :</label>
    <f:input type="text" class="form-control" name="diachinguoinhan" id="exampleInputEmail1" placeholder="Nhập địa chỉ giao hàng" path="diaChiNguoiNhan"/>
     <f:errors style="color:red" path="diaChiNguoiNhan" element="div"></f:errors>
     <br>
      <div class="thanhtien">Tổng tiền : <span><fmt:formatNumber>${tongTien }</fmt:formatNumber> VNĐ</span></div><br>
    
      <div class="nutthanhtoan">
        <button class="nutthemgiott" type="submit"><a href="#"><i class="fa-brands fa-cc-apple-pay"></i><p class="gian">Thanh Toán</p></a></button>
      </div>
  </f:form>
     </div>
    </div>
    </div>
   	<br>
      
      <div class="nutthanhtoan1">
        <button class="nutthemgiott1"><a href="${pageContext.request.contextPath }/index"><i class="fa-solid fa-angle-left"></i><p class="gian">Tiếp Tục Mua</p></a></button>
      </div>
      <br>


      </div>
      <br>
      </c:if>

<jsp:include page="common/_footer.jsp"></jsp:include>
<script type="text/javascript">
		var message = document.getElementById("message").value;
		var type = document.getElementById("type").value;
		if(message != ""){
			Swal.fire(message, '', type);
		}
		
</script>
</body>
</html>