<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
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
    <script src="https://kit.fontawesome.com/999051c9de.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<jsp:include page="common/_header.jsp"></jsp:include>
            <h1 class="giua"><i class="fa-solid fa-bag-shopping"></i> Sản Phẩm</h1>
      <br>
      
      <div class="row">
        <div class="col-md-1">
            <div class="col-md-6 category" data-mdb-filter="color">
               <h3 class="fa-lg"> Category</h3>
                <div class="form-check mt-3">
               
                 <input
                    class="form-check-input"
                    type="radio"
                    name="inlineRadioOptions"
                    id="inlineRadio1"
                    value="Tất cả"
                    checked
                    onchange="window.location.replace('${pageContext.request.contextPath }/product')"
                  />
                  <label class="category-text" for="inlineRadio1">Tất Cả</label>
               
                 
                   <c:forEach items="${listCate }" var="c">
                <c:if test="${c.trangThai == 0 }">
                 <input
                    class="form-check-input"
                    type="radio"
                    name="inlineRadioOptions"
                    id="inlineRadio1"
                    value="${c.id }"
                    ${id == c.id ? 'checked="checked"' : '' }
                    onchange="window.location.replace('${pageContext.request.contextPath }/product/${c.id }')"
                    ${c.id == cate ? 'checked="checked"' : '' }
                  />
                  <label class="category-text" for="inlineRadio1">${c.ten }</label>
            
                
                </c:if>
                
                </c:forEach>
                </div>
               
               </div>
              
            
          </div>
          <div class="col-md-11">
            <div class="container">
                <div class="row">
                  <c:forEach items="${list }" var="p">
          <div class="col-md-3 col-6">
            <div class="thumbnail xoagach">
              <a href="${pageContext.request.contextPath }/detail/${p.id }">
                <div class="anhsp"><c:if test="${p.giamGia > 0 }"><span class="giamgia1" >- ${p.giamGia}%</span></c:if><img src="${pageContext.request.contextPath}/views/img/${p.anh}" alt="Lights" style="width:100%"></div>
                <div class="tensp">
                  ${fn:toUpperCase(p.tieuDe)}
                </div>
              </a>
             <div class="line"><p class="money"> <c:if test="${p.giamGia < 1 }"><fmt:formatNumber>${p.gia}</fmt:formatNumber> VNĐ</c:if></p><p class="money"> <c:if test="${p.giamGia > 0 }"><fmt:formatNumber>${p.gia - (p.gia * (p.giamGia /100))}</fmt:formatNumber> VNĐ</c:if></p>
             <p class="gach"><c:if test="${p.giamGia >0 }"><fmt:formatNumber>${p.gia}</fmt:formatNumber> VNĐ</c:if></p>
              
            </div>
              <br>
              <div>
                <button class="nutthemgio"><a href="${pageContext.request.contextPath }/detail/${p.id }"><i class="fa-solid fa-cart-shopping"></i><p class="gian">Mua Ngay</p></a></button>
              </div>
            </div>
<!--             <div class="ribbon-wrap"> -->
<!--               <div class="ribbon"><img class="fire" src="./img/fire.gif"> HOT</div> -->
<!--             </div> -->
        </div>
          </c:forEach>
           </div>
              <c:if test="${cate == null }">
               <nav aria-label="Page navigation example">
         
                  <ul class="pagination">
                  <li class="page-item"><a class="page-link" href="product">1</a></li>
                  <c:forEach begin="2" end="${count }"  var="i">
                  <li class="page-item"><a class="page-link" href="?pageNum=${i}">${i }</a></li>
                  </c:forEach>
   
  </ul>
</nav>
              </c:if>
            <c:if test="${cate != null }">
             <nav aria-label="Page navigation example">
         
                  <ul class="pagination">
                  <li class="page-item"><a class="page-link" href="?category=${cate }">1</a></li>
                  <c:forEach begin="2" end="${count }"  var="i">
                  <li class="page-item"><a class="page-link" href="?category=${cate }&page=${i}">${i }</a></li>
                  </c:forEach>
   
  </ul>
</nav>
            </c:if>
              </div>
              
          </div>
      </div>
<jsp:include page="common/_footer.jsp"></jsp:include>
</body>
</html>