// ignore_for_file: public_member_api_docs

class Pagination {
  Pagination({
    this.perPage,
    this.currentPage,
    this.nextPage,
    this.totalPages,
    this.totalRecords,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        perPage: json['per_page'] as num?,
        currentPage: json['current_page'] as num?,
        nextPage: json['next_page'] as dynamic,
        totalPages: json['total_pages'] as num?,
        totalRecords: json['total_records'] as num?,
      );
  num? perPage;
  num? currentPage;
  dynamic nextPage;
  num? totalPages;
  num? totalRecords;

  Map<String, dynamic> toJson() => {
        'per_page': perPage,
        'current_page': currentPage,
        'next_page': nextPage,
        'total_pages': totalPages,
        'total_records': totalRecords,
      };
}
