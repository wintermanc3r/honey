<!--
	// Googlemaps
	//<![CDATA[
	var WINDOW_HTML = '<font style="font-family: Verdana; font-size: 10px;"><font style="font-weight: bold; color: #00A200;">Hotel Bellevue</font><br /><br />Via Statale, 33<br />23013 Cosio Valtellino (Sondrio) - Italia</font>';
	
	function initialize(){
		if(GBrowserIsCompatible()){
			var map = new GMap2(document.getElementById("mappa"));
			map.addControl(new GSmallMapControl());
			map.addControl(new GMapTypeControl());
			map.setCenter(new GLatLng(46.133828, 9.561174), 13);
			var marker = new GMarker(new GLatLng(46.133828, 9.561174));
      map.addOverlay(marker);
      GEvent.addListener(marker, "click", function(){
        marker.openInfoWindowHtml(WINDOW_HTML);
      });
      marker.openInfoWindowHtml(WINDOW_HTML);
			var ovcontrol = new GOverviewMapControl(new GSize(180,180)); 
      map.addControl(ovcontrol);
		}
	}
	//]]>
	
	// Apre una pop-up centrata
	function centerPopup(typePage, number){
		if(typePage == 'h'){
			w = 500;
			h = 332;
		}
		else if(typePage == 'v'){
			w = 249;
			h = 332;
		}
			
		var l = Math.floor((screen.width-w)/2);
		var t = Math.floor((screen.height-h)/2);
		var site = window.open("pages/gallery.php?num=" + number + "", "popup", "toolbar=no, location=no, directories=no, status=yes, menubar=no, scrollbars=yes, resizable=no, width=" + w + ", height=" + h + ", top=" + t + ", left=" + l);
		site.focus();
	}
	
	// Controlla l'invio della form "contatti"
	function checkContatti(){
		var item = document.contatti;
		var goodEmail = item.mail.value.match(/\b(^(\S+@).+((\.com)|(\.net)|(\.edu)|(\.mil)|(\.gov)|(\.org)|(\..{2,2}))$)\b/gi);
		
		if(item.name.value == ''){
			alert("Attenzione!\nIl campo NOME non è stato compilato correttamente...");
			item.name.focus();
		}
		else if(item.surname.value == ''){
			alert("Attenzione!\nIl campo COGNOME non è stato compilato correttamente...");
			item.surname.focus();
		}
		else if(!goodEmail){
			alert("Attenzione!\nIl campo E-MAIL non è stato compilato correttamente...");
			item.mail.focus();
		}
		else if(item.phone.value != '' && isNaN(item.phone.value)){
			alert("Attenzione!\nIl campo TELEFONO/CELLULARE non è numerico...");
			item.phone.focus();
		}
		else if(item.what.value == ''){
			alert("Attenzione!\nIl campo RICHIESTA non è stato compilato correttamente...");
			item.what.focus();
		}
		else if(item.privacy.checked == false)
			alert("Attenzione!\nE' necessario confermare la lettura dell'informativa sulla PRIVACY...");
		else{
			item.go.value = 'Y';
			item.submit();
		}
	}
	
	// Mostra/nasconde la visibility del div "id"
	function showHideDiv(id){
		if(id == 'lombardia'){
			document.getElementById('lombardia').style.display = "block";
			document.getElementById('valtellina').style.display = "none";
			document.getElementById('cosio_valtellino').style.display = "none";			
		}
		else if(id == 'valtellina'){
			document.getElementById('lombardia').style.display = "none";
			document.getElementById('valtellina').style.display = "block";
			document.getElementById('cosio_valtellino').style.display = "none";			
		}
		else if(id == 'cosio_valtellino'){
			document.getElementById('lombardia').style.display = "none";
			document.getElementById('valtellina').style.display = "none";
			document.getElementById('cosio_valtellino').style.display = "block";			
		}
	}
	
	// Mostra/nasconde la visibility del div "visite"
	function showHideVisit(){
		if(document.getElementById('visite').style.display == "none")
			document.getElementById('visite').style.display = "block";
		else
			document.getElementById('visite').style.display = "none";
	}
	
	// Passa l'id della news per gli input di modifica
	function passForSubId(idValue){
		document.form_news.id_main.value = idValue;
		document.form_news.cmd.value = 'news';
		
		document.form_news.submit();
	}
	
	// Submit della select per la paginazione
	function passForPid(pageValue){
		window.location.href = "index.php?cmd=news&page=" + pageValue;
	}
	
	// Elimina la news
	function delNews(idValue, nameValue){
		if(confirm("Sei sicuro di voler eliminare questa news?")){
			document.news_events.what.value = idValue + "|" + nameValue;
			document.news_events.cmd.value = 'del_news';
			document.news_events.submit();
		}
	}
	
	// Submit della form di modifica degli eventi
	function passForEid(){
		document.news_events.cmd.value = "";
		document.news_events.submit();
	}
	
	// Controllo della form inserimento news & eventi
	function insNews(idValue){
		if(document.news_events.titolo.value == ""){
			alert("Attenzione!\nIl titolo della news non è stato inserito...");
			document.news_events.titolo.focus();
		}
		else{
			if(idValue != "" && idValue != "N"){
				document.news_events.what.value = idValue;
				document.news_events.cmd.value = "mod_news";
			}
			
			document.news_events.submit();
		}
	}
	
	// Elimina l'immagine selezionata dalla news
	function delImgNews(idValue, nameValue){
		if(confirm("Sei sicuro di voler eliminare questo allegato?")){
			document.news_events.what.value = idValue + "|" + nameValue;
			document.news_events.cmd.value = "del_news_img";
			document.news_events.submit();
		}
	}
//-->

