<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link href="css/styleMyynti.css" rel="stylesheet" type="text/css">
<title>Lis�� asiakas</title>
</head>
<body>
<form id = "tiedot">
	<table>
		<thead>
			<tr>
				<th colspan="5"><label1><span id="takaisin">Takaisin listaukseen</span></label1></th>
			</tr>
			<tr>
				<th><label>Etunimi</label></th>
				<th><label>Sukunimi</label></th>
				<th><label>Puhelinnumero</label></th>
				<th><label>S�hk�postiosoite</label></th>
				<th><label>Lis��</label></th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type = "text" name = "etunimi" id = "etunimi"></td>
				<td><input type = "text" name = "sukunimi" id = "sukunimi"></td>
				<td><input type = "text" name = "puhelin" id = "puhelin"></td>
				<td><input type = "text" name = "sposti" id = "sposti"></td>
				<td><input type = "submit" id = "tallenna" value = "Lis��"></td>
			</tr>
		</tbody>
	</table>
</form>
<span id = "ilmo"></span>
</body>
<script>
$(document).ready(function(){
	$("#takaisin").click(function(){
		document.location="listaaasiakkaat.jsp";
	});
	$("#tiedot").validate({
		rules: {
			etunimi: {
				required: true,
				minlength: 2
			},
			sukunimi: {
				required: true,
				minlength: 2
			},
			puhelin: {
				required: true,
				minlength: 7
			},
			sposti: {
				required: true,
				minlength: 5
			}
		},
		messages: {
			etunimi: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			sukunimi: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			puhelin: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			sposti: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			}
		},
		submitHandler: function(form) {
			lisaaTiedot();
		}
	});
});
//funktio tietojen lis��mist� varten. Kutsutaan backin POST-metodia ja v�litet��n kutsun mukana uudet tiedot json-stringin�.
//POST /autot/
function lisaaTiedot() {
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray());
	$.ajax({url:"asiakkaat", data: formJsonStr, type: "POST", dataType: "json", success: function(result) {
		if(result.response==0) {
			$("#ilmo").html("Asiakkaan lis��minen ep�onnistui.");
		} else if (result.response==1) {
			$("#ilmo").html("Asiakkaan lis��minen onnistui.");
			$("#etunimi", "#sukunimi", "#puhelin", "#sposti").val("");
		}
	}});
}
</script>
</html>