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
        perPage: json['per_page'] as int?,
        currentPage: json['current_page'] as int?,
        nextPage: json['next_page'] as dynamic,
        totalPages: json['total_pages'] as int?,
        totalRecords: json['total_records'] as int?,
      );
  int? perPage;
  int? currentPage;
  dynamic nextPage;
  int? totalPages;
  int? totalRecords;

  Map<String, dynamic> toJson() => {
        'per_page': perPage,
        'current_page': currentPage,
        'next_page': nextPage,
        'total_pages': totalPages,
        'total_records': totalRecords,
      };
}
