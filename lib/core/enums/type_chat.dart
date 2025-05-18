enum TypeChat {
  text,
  image,
  video,
  audio,
  file,
  location,
  contact,
  link,
  custom,
}

TypeChat getTypeChat(String type) {
  return TypeChat.values.firstWhere((element) => element.name == type);
}
