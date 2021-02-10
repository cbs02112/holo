<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/resource/etc/color.jsp"%>

<html>
<head>
<title>자유게시판</title>
<link href="/holo/resource/style/style_board.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/holo/se2/js/HuskyEZCreator.js" charset="utf-8"></script> 
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/holo/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>
</head>

<script>
	function changeSelect(cat_a) {
		if (cat_a == "1") {
			$("[name=category_b]").hide();
		}else{
			$("[name=category_b]").show();
		}
	};
	function validateForm(){
		var cat_a = $("[name=category_a]").val();
		var cat_b = $("[name=category_b]").val();
		var subject = $("[name=subject]").val();
		var content = $("[name=content]").val();
		if(cat_a==null){
			alert("대분류를 선택해주세요!!");
			return false;
		}else if(cat_a=="2"&&cat_b==null){
			alert("소분류를 선택해주세요!!");
			return false;
		}else if(subject==null||subject==""){
			alert("제목을 입력해주세요!");
			return false;
		}else if(content==null||content==""){
			alert("내용을 입력해주세요!");
			return false;
		}
	};
</script>

<body bgcolor="${bodyback_c}">
	<center>
		<b>작성하기</b> <br>
		<form method="POST" id="writeForm" action="/holo/com/pro.holo" onsubmit="return validateForm()">
			<input type="hidden" name="articlenum" value="${cdto.articlenum}">
			<input type="hidden" name="mode" value="${mode}">
			<table width="1000" border="1" cellspacing="0" cellpadding="0" align="center">
				<tr>
					<select onchange="changeSelect(this.value)" name="category_a">
						<option disabled selected>게시판선택</option>
						<option value="1">자유게시판</option>
						<option value="2">지역별게시판</option>
					</select>
					<select name="category_b">
						<option disabled selected>분류 선택</option>
						<option value="1">서울</option>
						<option value="2">강원</option>
						<option value="3">인천/경기</option>
						<option value="4">대구/경북</option>
						<option value="5">대전/충청</option>
						<option value="6">광주/전라</option>
						<option value="7">부산/경남</option>
					</select>
				</tr>
				<tr>
					<td width="50" align="center" bgcolor="${value_c}">
						제 목
					</td>
					<td width="950">
						<input type="text" style="resize: none; width: 100%;" name="subject" value="${cdto.subject}">
					</td>
				</tr>
				<tr>
					<td width="50" align="center" bgcolor="${value_c}">내 용</td>
					<td width="950">
						<textarea rows="20" cols="30" id="content" name="content" style="resize: none; width: 100%;">${cdto.content}</textarea>
					</td>
				</tr>
				<tr>
					<td colspan=2 align="center" bgcolor="${value_c}">
						<c:if test="${mode=='new'}">
							<button id="writebtn">글쓰기</button>
						</c:if>
						<c:if test="${mode=='edit'}">
							<button id="writebtn">수정하기</button>
						</c:if>
						<input type="reset" value="다시작성"/> 
						<input type="button" value="목록보기" OnClick="window.location='/holo/com/list.holo?category_a=${cat_a}&category_b=${category_b}&pagenum=${pagenum}'"/>
					</td>
				</tr>
			</table>
		</form>
</body>
</html>


<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
 oAppRef: oEditors,
 elPlaceHolder: "content",
 sSkinURI: "/holo/se2/SmartEditor2Skin.html",
 fCreator: "createSEditor2"

});

window.onload = function(){
	$("[name=category_a]").val(${cat_a});
	if(${cat_a=='1'}){
		$("[name=category_b]").hide();
	}else{
		$("[name=category_b]").val(${cat_b});
	}
   var btn = document.getElementById("writebtn");
   btn.onclick = function(){
		 oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	     //submitContents(btn);
   }
}

 
 function pasteHTML(filepath){
       var sHTML = '<img src="<%=request.getContextPath()%>/save/'+filepath+'">';
       oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
   }
</script>