class DiseasesDetails{
  final String plant;
  final List<Disease> diseaseList;

  @override
  String toString() {
    return 'DiseasesDetails{plant: $plant, diseaseList: $diseaseList}';
  }

  DiseasesDetails({required this.diseaseList,required this.plant});
  factory DiseasesDetails.fromJson(doc,list){
    return DiseasesDetails(diseaseList: list, plant: doc['plant']);
  }
}

class Disease{
  final String disease_name;
  List<String> prevention_cure,symptoms,images;

  Disease({required this.disease_name,required this.images,required this.prevention_cure,required this.symptoms});
  factory Disease.fromJson(doc){
    return Disease(
        disease_name: doc['disease_name'],
        images: List<String>.from(doc['images']),
        prevention_cure: List<String>.from(doc['prevention_cure']),
        symptoms: List<String>.from(doc['symptoms']),
    );
  }

}