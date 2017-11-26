//Premier parseur
function premierParseur(str){
	var arr = str.split("\n");
	for(var i = arr.length - 1; i >= 0; i--){
		if ((arr[i][0] == " ") || (arr[i][0] == "\t")){
			var test = arr[i].trim();
			arr[i-1] += test;
			arr.splice(i, 1);
		}
	}
	return arr;
}

//Second parseur
function finNext(str, charactere){
	var index = 1;
	while(str[index] != charactere){
		index++;
		if(index == str.length){
			throw "outOfBounds";
		}
	}
	return index;
}
function findMatching(str, charactere, characterebis){
	var index = 1;
	var compteur = 1;
	while(compteur > 0){
		if(str[index] == charactere){
			compteur --;
		}
		else if (str[index] == characterebis){
			compteur++;
		}
		index++;
		if(index == str.length){
			throw "outOfBounds";
		}
	}
	return index;
}
function secondParseur(str){
	var acc = [];
	str = str.trim();
	var index = 0;
	while(true){
		if(str == ""){
			break;
		}
		try{
			switch (str[0]){
				case "'":
					index = finNext(str, "'") + 1;
					break;
				case '"':
					index = finNext(str, '"') + 1;
					break;
				case "(":
					index = findMatching(str, "(", ")");
					break;
				case "[":
					index = findMatching(str, "[", "]");
					break;
				case "{":
					index = findMatching(str, "{", "}");
					break;
				default:
					index = finNext(str, " ");
			}
			acc.push(str.slice(0, index));
			str = str.slice(index).trim();
		}
		catch(test){
			acc.push(str);
			break;
		}
	}
	return acc;
}
function interpret(){
	var code = document.getElementById("input").value;
	var premier = premierParseur(code);
	var second = premier.map(secondParseur);
	console.log(second.join());
}
//Archive
//~ function secondParseur(str){
	//~ var index = 0;
	//~ str = str.trim();
	//~ if(str == ""){
		//~ return [];
	//~ }
	//~ else{
		//~ switch (str[0]) {
			//~ case "'":
				//~ index = finNext(str, "'");
				//~ break;
			//~ case '"':
				//~ index = finNext(str, '"');
				//~ break;
			//~ case "(":
				//~ index = findMatching(str, "(", ")");
				//~ break;
			//~ case "[":
				//~ index = findMatching(str, "[", "]");
				//~ break;
			//~ case "{":
				//~ index = findMatching(str, "{", "}");
				//~ break;
			//~ default:
				//~ index = finNext(str, " ") - 1;
		//~ }
		//~ return [str.slice(0, index)].concat(secondParseur(str.slice(index)));
	//~ }
//~ }