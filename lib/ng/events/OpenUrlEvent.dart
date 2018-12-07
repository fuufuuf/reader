class OpenUrlEvent {
  final Uri url;

  OpenUrlEvent(this.url);

  OpenUrlEvent.urlString(String urlString) : this(Uri.parse(urlString));
}
