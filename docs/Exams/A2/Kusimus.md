# Вопросы с партнером

## Описание
Последним этапом части `Raagimine` (Говорение) нужно по выданной карте идей задавать вопросы партнеру и отвечать на вопросы партнера.

Партнером будет такой же экзаменуемый и незнакомый Вам человек, поэтому может быть непросто понять с непривычки его речь.

Было бы неплохо познакомиться со своим будущим партнером заранее и попробовать потренироваться, задавая друг другу вопросы.

Это позволит узнать человека поближе, привыкнуть к его голосу и произношению, а также заранее увидеть, какие вопросы ему можно будет задавать на самом экзамене.

Ниже приведен список простых вопросов, которые можно задавать друг другу.

Также приведен QR-код этой страницы, который может считать телефоном ваш партнер и открыть в телефоне эту же страницу с вопросами.

Далее вы будете задавать вопросы друг другу.

Например, вы можете задавать вопросы сверху вниз, а ваш партнер будет вам задавать вопросы снизу вверх.

## Вопросы

<!-- HTML разметка -->

<a id="resetLink" href="?reset">Сбросить генерацию</a>
<a href="?generate">Сгенерировать новые списки</a>

<div id="qrcode"></div>

<h3 id="listFullHeader">Полный список</h3>
<table id="listFull">
</table>

<h3 id="listAHeader">Первый список</h3>
<table id="listA">
</table>

<h3 id="listBHeader">Второй список</h3>
<table id="listB">
</table>

<!-- JavaScript функция -->

<script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>
<script>
	const list = [
		"Mis sinu nimi on? - Как тебя зовут?",
		"Mis sinu perekonnanimi on? - Как твоя фамилия?",
		"Kui vana sa oled? - Сколько тебе лет?",
		"Kus sa sündisid? - Где ты родился?",
		"Millal sa sündisid? - Когда ты родился?",
		"Mis aastal sa sündisid? - В каком году ты родился?",
		"Mis kuupäeval sa sündisid? - В какой день месяца ты родился?",
		"Kust sa pärit oled? - Откуда ты родом?",
		"Kus sa elad? - Где ты живешь?",
		"Kus sa varem elasid? - Где ты раньше жил?",
		"Kellena sa töötad? - Кем ты работаешь?",
		"Kus sa töötad? - Где ты работаешь?",
		"Millega sa tööle sõidad? - Чем ты добираешься на работу?",
		"Millal sinu tööpäev algab ja lõpeb? - Когда начинается и заканчивается твой рабочий день?",
		"Millal sa hommikul ärkad? - Когда ты утром просыпаешься?",
		"Mida sa hommikusöögiks sööd? - Что ты ешь на завтрак?",
		"Mis on sinu lemmikhommikusöök? - Какая твоя любимая еда на завтрак?",
		"Mis on sinu lemmiktoit? - Какая твоя любимая еда?",
		"Kas sulle maitsev jäätis? - Тебе нравится мороженое?",
		"Mida sa tööpäeva õhtul teed? - Что ты делаешь в рабочий день вечером?",
		"Mida sa nädalavahetusel teed? - Что ты делаешь на выходных?",
		"Mida sa talvel teed? - Что ты делаешь, когда зима?",
		"Kas sa oskad suusatada? - Ты умеешь кататься на лыжах?",
		"Kas sa teed sporti? - Ты занимаешься спортом?",
		"Kas sulle meeldib metsas jalutada? - Ты любишь гулять в лесу?",
		"Kas sulle meeldib reisida? - Ты любишь путешествовать?",
		"Kui tihti sa reisid? - Как часто ты путешествуешь?",
		"Kuhu sa viimati reisisid? - Куда ты путешествовал в последний раз?",
		"Millal sa viimati reisisid? - Когда ты путешествовал последний раз?",
		"Mitmetoaline sinu korter on? - Сколько комнатная у тебя квартира?",
		"Mitmekorruseline sinu maja on? - Сколькиэтажный у тебя дом?",
		"Mitmendal korrusel sa elad? - На каком этаже ты живешь?",
		"Kas sul on suur pere? - У тебя большая семья?",
		"Kes sinu peres on? - Кто в твоей семье?",
		"Kas sulle meeldib kinos käia? - Ты любишь ходить в кино?",
		"Kas sulle meeldib raamatuid lugeda? - Ты любишь читать книги?",
		"Kelleks sa õppisid? - На кого ты учился?",
		"Kui tihti sa arsti juures käid? - Как часто ты ходишь к врачу?",
		"Kellele sa helistad, kui sa oled haige? - Кому ты звонишь, когда ты болен?",
		"Mis on sinu lemmikaastaaeg? - Какое твое любимое время года?",
		"Kas sul on lemmikloom? - У тебя есть домашнее животное?",
		"Mis sinu kassi nimi on? - Как зовут твою кошку?",
		"Kuhu sa tahad suvel sõita? - Куда ты хочешь летом поехать?",
		"Kas sul on autojuhiluba? - У тебя есть водительские права?",
		"Kellega sa sünnipäeva tähistad? - С кем ты отмечаешь день рождения?",
		"Mis on su lemmikpüha? - Какой твой любимый праздник?",
		"Kas sulle meeldib ujuda? - Тебе нравится плавать?",
		"Kas sa puhkasid sellel aastal? - Ты отдыхал в этом году?",
		"Kuhu sa tahad järgmisel aastal sõita? - Куда ты хочешь поехать в следующем году?",
		"Mis on sinu lemmikjook? - Какой твой любимый напиток?",
		"Kui tihti sa turul käid? - Как часто ты ходишь на рынок?",
		"Mida sa poest ostad? - Что ты покупаешь в магазине?",
		"Mis poest sa toitu ostad? - В каком магазине ты покупаешь еду?",
		"Kas sul on vend või õde? - У тебя есть брат или сестра?",
		"Kas sulle meeldib seeni korjata? - Ты любишь собирать грибы?",
		"Mis ilm praegu on? - Какая сейчас погода?",
		"Mis sinu hobi on? - Какое твое хобби?",
		"Mis kell sa magama lähed? - Во сколько ты ложишься спать?",
		"Mida sa igal hommikul teed? - Что ты делаешь каждое утро?",
		"Kas sulle meeldib süüa teha? - Ты любишь готовить?",
		"Mida sa tavaliselt pühapäeval teed? - Что ты обычно делаешь в воскресенье?",
		"Kas sul on kodus lilled? - У тебя дома есть цветы?",
		"Mis sinu maja lähedal on? - Что находится рядом с твоим домом?",
		"Kas sa jood kohvi piimaga või ilma? - Ты пьешь кофе с молока или без?",
		"Kus sa tavaliselt lõunat sööd? - Где ты обычно обедаешь?",
		"Kas sul on jalgratas? - У тебя есть велосипед?",
		"Mis keeli sa räägid? - На каких языках ты говоришь?",
		"Mis ilm sulle meeldib? - Какая погода тебе нравится?",
		"Kui kaua sa tööle sõidad? - Как долго ты едешь на работу?",
		"Kas sulle meeldib Tallinnas elada? - Тебе нравится жить в Таллине?",
		"Mis on sinu lemmikkoht linnas? - Какое твое любимое место в городе?"
	];

	document.addEventListener("DOMContentLoaded", function() {
		let pars = window.location.search.slice(1);

		let indexes;
		if(!pars) {
			const table = document.getElementById("listFull");
			var num = 1;
			list.forEach((item, index) => {
				const row = table.insertRow();
				const cell = row.insertCell();
				cell.textContent = num + ". " + item;
				num++;
		   });

			document.getElementById("resetLink").remove();
			document.getElementById("listAHeader").remove();
			document.getElementById("listBHeader").remove();
			document.getElementById("listA").remove();
			document.getElementById("listB").remove();
		} else if (pars === "generate"){
			indexes = list.map((_, index) => index).sort(() => Math.random() - 0.5);
			pars = indexes.map(index => String(index).padStart(2, '0')).join('');
			window.location.search = pars;
		} else if(pars === "reset") {
			window.location.search = "";
		} else {
			indexes = [];
			for (let i = 0; i < pars.length; i += 2) {
				indexes.push(+pars.substring(i, i + 2));
			}

			const half = Math.ceil(indexes.length / 2);
			const listA = indexes.slice(0, half);
			const listB = indexes.slice(half);

			const tableA = document.getElementById("listA");
			const tableB = document.getElementById("listB");

			var num = 1;
			listA.forEach(index => {
				const row = tableA.insertRow();
				const cell = row.insertCell();
				cell.textContent = num + ". " + list[index];
				num++;
			});

			num = 1;
			listB.forEach(index => {
				const row = tableB.insertRow();
				const cell = row.insertCell();
				cell.textContent = num + ". " + list[index];
				num++;
			});

			new QRCode(document.getElementById("qrcode"), {
				text: window.location.href,
				width: 256,
				height: 256,
				colorDark : "#000000", 
				colorLight : "#ffffff",
				correctLevel : QRCode.CorrectLevel.H 
			});

			document.getElementById("listFullHeader").remove();
			document.getElementById("listFull").remove();
		}
	});
</script>
