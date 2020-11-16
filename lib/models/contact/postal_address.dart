class PostalAddress {
  PostalAddress(
      {this.label,
        this.street,
        this.city,
        this.postcode,
        this.region,
        this.country});
  String label, street, city, postcode, region, country;

  PostalAddress.fromMap(Map m) {
    label = m["label"];
    street = m["street"];
    city = m["city"];
    postcode = m["postcode"];
    region = m["region"];
    country = m["country"];
  }