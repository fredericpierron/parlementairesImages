JSONArray values;
JSONObject fiche;
PImage[] trombinoscope;
Boolean ok = true;
String[] listePhotos = new String [1];
String[] listeDesNoms = new String[1];
String url= "http://www2.assemblee-nationale.fr/static/tribun/14/photos/";


void setup(){
  size(150,193);
  background(255);
  values = loadJSONArray("2014_reserve.json");
  String idEnCours = "rien";
  
  for(int i = 0; i < values.size(); i++){
    fiche = values.getJSONObject(i);
    String idDepute = fiche.getString("ID_Acteur");
    String nomDepute = fiche.getString("Nom");
    nomDepute = nomDepute + " " + fiche.getString("Prénom");
    
    if (idDepute.equals(idEnCours) == false){
      if (idDepute.equals("NULL") == false) {
        String idPhotoDepute = idDepute.substring(2, idDepute.length())+".jpg";
        listePhotos = append(listePhotos,idPhotoDepute);
        listeDesNoms = append(listeDesNoms,nomDepute);
      }
      idEnCours = idDepute;
    }
  }
  trombinoscope = new PImage[listePhotos.length-1];

  for (int k=0; k < trombinoscope.length; k++){
    trombinoscope[k]=loadImage(url+listePhotos[k+1]);
  }
}


void draw(){
  frameRate(1);
  if(ok){
    for(int i=0; i <trombinoscope.length; i++){
      image(trombinoscope[i],0,0);
      save(listeDesNoms[i+1]+".jpg");
    }
  }
  ok=false;
}