
class BaseResponse<T> {
  BaseResponse({
    this.data,
    this.dataList,
    this.message,
    this.statusCode,
    this.lang,
  });

  BaseResponse.fromJson(dynamic json) {
    print('Base Response Data Type $T');
    switch (T) {
      // case const (Product):
      //   if (json['data'] is List) {
      //     dataList = [];
      //     json['data'].forEach((v) {
      //       dataList?.add(Product.fromJson(v) as T);
      //     });
      //   } else {
      //     data = json['data'] != null
      //         ? Product.fromJson(json['data']) as T?
      //         : null;
      //   }
    }

    message = json['message'];
    statusCode = json['status_code'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  T? data;
  List<T>? dataList;
  String? message;
  int? statusCode;
  String? lang;
  Meta? meta;
}

class Meta {
  Meta({
    this.pagination,
  });

  Meta.fromJson(dynamic json) {
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Pagination? pagination;
}

class Pagination {
  Pagination({
    this.total,
    this.perPage,
    this.count,
    this.currentPage,
  });

  Pagination.fromJson(dynamic json) {
    total = json['total'];
    perPage = json['per_page'];
    count = json['count'];
    currentPage = json['current_page'];
  }

  int? total;
  int? perPage;
  int? count;
  int? currentPage;
}
