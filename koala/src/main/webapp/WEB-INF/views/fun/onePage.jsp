<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
	integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

</head>
<style>
.toolbar {
	width: 80%;
	height: 50px;
	margin: auto;
}

.topName {
	width: 13%;
	height: 100%;
	box-sizing: border-box;
	background-color: black;
	border-top: 1px solid rgb(248, 185, 147);
	border-top-width: 5px;
	float: left;
}

.topimg {
	width: 50%;
	height: 100%;
	box-sizing: border-box;
	float: left;
}

.soname {
	width: 50%;
	height: 100%;
	box-sizing: border-box;
	float: left;
	padding-right: 20px;
}

.topbinarea {
	width: 38%;
	height: 100%;
	box-sizing: border-box;
	float: left;
	font-size: 20px;
	padding-top: 13px;
}

.savearea, .loadarea, .downarea {
	width: 13%;
	height: 100%;
	box-sizing: border-box;
	float: left;
	text-align: center;
	padding-top: 5px;
	font-weight: bold;
	font-size: 22px;
}

.loadarea, .downarea {
	padding-left: 25px;
}

.lastbin {
	width: 10%;
	height: 100%;
	box-sizing: border-box;
	float: left;
	text-align: center;
	padding-top: 5px;
	font-weight: bold;
	font-size: 22px;
}

.togeSql {
	width: 80%;
	height: 1000px;
	margin: auto;
}

.sqlArea {
	width: 90%;
	height: 100%;
	box-sizing: border-box;
	float: left;
}

#testnum {
	width: 4%;
	height: 100%;
	box-sizing: border-box;
	float: left;
}

.middlebin {
	width: 1%;
	height: 100%;
	box-sizing: border-box;
	float: left;
}

#textare {
	width: 95%;
	height: 100%;
	box-sizing: border-box;
	float: left;
	outline: none;
}

.userConarea {
	width: 10%;
	height: 100%;
	box-sizing: border-box;
	float: left;
}

.CodeMirror {
	width: 100%;
	height: 100%;
	box-sizing: border-box;
}

span {
	color: red;
}

.userIn {
	width: 100%;
	height: 85%;
	background-color: rgb(50, 50, 50);
	box-sizing: border-box;
}

.btnsarea {
	width: 100%;
	height: 10%;
	background-color: rgb(50, 50, 50);
}

.userInarea {
	width: 100%;
	height: 5%;
	text-align: center;
	padding-top: 10px;
	box-sizing: border-box;
	background-color: rgb(50, 50, 50);
}

#testnumin {
	-ms-overflow-style: none;
	scrollbar-width: none;
	background-color: gray;
}

#testnumin::-webkit-scrollbar {
	display: none;
}
</style>

<body>
	<script>
		var socket;
		function connect() {
			if (!socket) {
				socket = new WebSocket("ws://localhost:8888/koala/ssss");
			}
			socket.onopen = function() {
				console.log("Connect Success");
			}
			socket.onclose = function() {
				console.log("disconnnect Success");
				$("#testnumin").val("1 ");
				$(".userInarea").html("현재 접속자<br>")
				$("#testarea").val(" >> 접속이 종료되었습니다.");
			}
			socket.onmessage = function(e) {
				var str = e.data;
				if (str.includes("###")) {
					// 회원 정보
					var user = "현재 접속자<br>";
					var userPack = ((e.data).replace("###", "")).split("///"); // 0번째는 회원 1번째는 현재까지 작성된 문자
					var userInfo = userPack[0].split(",");
					for ( var u in userInfo) {
						user += userInfo[u] + "\n";
					}
					$(".userInarea").html(user);
					if (userPack[1] != "null") {
						$("#testarea").val(userPack[1]); // 접속 직전의 정보를 토대로 뿌려준다.
						var test = $("#testarea").val().split("\n");
						var str = "";
						if (test.length > 0) {
							for (var i = 1; i <= test.length; i++) {
								str += i + " \n";
							}
							$("#testnumin").val(str);
						}
					}
				} else {
					// sql 내용
					$("#testarea").val(e.data);
					var test = $("#testarea").val().split("\n");
					var str = "";
					if (test.length > 0) {
						for (var i = 1; i <= test.length; i++) {
							str += i + " \n";
						}
						$("#testnumin").val(str);
					}
				}
			}
		}

		function disconnect() {
			try {
				socket.close();
				socket = "";
			} catch (e) {}
		}

		// send func
		$(function() {
			$("#testarea").on("keyup", function() {
				if (!socket) {
					$(this).val("");
					alert("접속 하지 않았습니다.");
				} else {
					var test = $(this).val().split("\n");
					var str = "";
					if (test.length > 0) {
						for (var i = 1; i <= test.length; i++) {
							str += i + " \n";
						}
						$("#testnumin").val(str);
					}
					var testing = $("#testarea").val().split("\n");
					var testingStr = "";
					for (var i = 0; i < testing.length; i++) {
						testingStr += testing[i];
					}
					socket.send($(this).val());
				}
			});

			// Scroll sync
			$("#testarea").scroll(function() {
				$("#testnumin").scrollTop($("#testarea").scrollTop());
				$("#testnumin").scrollLeft($("#testarea").scrollLeft());
			});
			$("#testnumin").scroll(function() {
				$("#testarea").scrollTop($("#testnumin").scrollTop());
				$("#testarea").scrollLeft($("#testnumin").scrollLeft());
			});

			// Download
			$("#ttt").on("click", function() {
				var text = document.getElementById('testarea').value;
				var fileBlob = new Blob([ text ], {
					type : 'text/plain'
				});

				var a = document.createElement('a');
				a.href = URL.createObjectURL(fileBlob);
				a.download = 'koalaSQL.sql';
				a.click();
			})
			// Save
			$("#sss").on("click", function() {
				if(!$(".topbinarea").text()){
	 				var title = prompt("파일명을 입력해주세요.");
	 				$(".topbinarea").text(title);
	 				var content = $("#testarea").val();
	 				socket.send("saveFile::"+title+"/"+content);
				}else{
					var caontent = $("#testarea").vale();
					socket.sent("saveFile::"+$(".topbinarea").text()+"/"+content);
				}
			});

			// Load
			$("#lll").on("click", function() {
				alert("불러왔습니다.");
			})

		})
	</script>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<br>
	<div class="toolbar">
		<div class="topName">
			<div class="topimg ic" style="text-align: center; padding-top: 10px;">
				<i class="fa-solid fa-database fa-2xl"></i>
			</div>
			<div class="soname ic ii"
				style="text-align: center; padding-top: 5px; font-weight: bold; font-size: 23px;">SQL</div>
		</div>
		<div class="topbinarea"></div>
		<div class="downarea">
			<i class="fa-solid fa-file-arrow-down fa-2xl ii ic"
				style="color: #ffffff;"></i>
			<button class="ii ic" type="button" id="ttt"
				style="background-color: transparent; border: 0; text-decoration: underline; text-decoration-thickness: 5px; text-decoration-color: rgb(40, 151, 223);">Download</button>
		</div>
		<div class="loadarea">
			<i class="fa-solid fa-file-import fa-2xl ii ic"
				style="color: #ffffff;"></i>
			<button class="ii ic" type="button" id="lll"
				style="background-color: transparent; border: 0; text-decoration: underline; text-decoration-thickness: 5px; text-decoration-color: rgb(40, 151, 223);">LoadFile</button>
		</div>
		<div class="savearea">
			<i class="fa-solid fa-floppy-disk fa-2xl ii ic"
				style="color: #ffffff;"></i>
			<c:choose>
			<c:when test="${not empty loginUser }">
				<button class="ii ic" type="button" id="sss"
					style="background-color: transparent; border: 0; text-decoration: underline; text-decoration-thickness: 5px; text-decoration-color: rgb(40, 151, 223);">SaveFile</button>
			</c:when>
			<c:otherwise>
				<button class="ii ic" type="button" 
					style="background-color: transparent; border: 0; text-decoration: underline; text-decoration-thickness: 5px; text-decoration-color: rgb(40, 151, 223); disabled">SaveFile</button>			
			</c:otherwise>
			</c:choose>
		</div>
		<div class="lastbin"></div>
	</div>
	<div class="togeSql">
		<div class="sqlArea">
			<div id="testnum" style="text-align: right; font-size: 22px;">
				<textarea class="ic ii" id="testnumin"
					style="width: 100%; height: 100%; text-align: right; box-sizing: border-box; border: none; border-right: 1px solid gray;"
					disabled></textarea>
			</div>
			<div class="middlebin ic ii" style="background-color: black"></div>
			<div id="textare">
				<textarea class="ic ii" id="testarea" class="testarea"
					style="width: 100%; height: 100%; font-size: 22px; resize: none; outline: none; border: none;"></textarea>
			</div>
		</div>
		<div class="userConarea">
			<div class="btnsarea ii ic">
				<c:choose>
				<c:when test="${not empty loginUser }">
					<button type="button" onclick="connect();" class="btn btn-success"
						style="width: 100%; height: 45%;">접속</button>
				</c:when>
				<c:otherwise>
					<button type="button" onclick="connect();" class="btn btn-success"
						style="width: 100%; height: 45%;" disabled>접속</button>
				</c:otherwise>
				</c:choose>
				<br>
				<div style="height: 10%; width: 100%;"></div>
				<c:choose>
				<c:when test="${not empty loginUser }">
					<button type="button" onclick="disconnect();" class="btn btn-danger"
						style="width: 100%; height: 45%;">종료</button>
				</c:when>
				<c:otherwise>
					<button type="button" onclick="disconnect();" class="btn btn-danger"
						style="width: 100%; height: 45%;" disabled>종료</button>
				</c:otherwise>
				</c:choose>
			</div>
			<div class="userInarea ii ic">현재 접속자</div>
			<div class="userIn ii ic"></div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>

</html>