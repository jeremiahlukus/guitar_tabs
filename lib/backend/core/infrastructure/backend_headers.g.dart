// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backend_headers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BackendHeadersImpl _$$BackendHeadersImplFromJson(Map<String, dynamic> json) =>
    _$BackendHeadersImpl(
      etag: json['etag'] as String?,
      link: json['link'] == null
          ? null
          : PaginationLink.fromJson(json['link'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$BackendHeadersImplToJson(
        _$BackendHeadersImpl instance) =>
    <String, dynamic>{
      'etag': instance.etag,
      'link': instance.link?.toJson(),
    };

_$PaginationLinkImpl _$$PaginationLinkImplFromJson(Map<String, dynamic> json) =>
    _$PaginationLinkImpl(
      maxPage: json['maxPage'] as int,
    );

Map<String, dynamic> _$$PaginationLinkImplToJson(
        _$PaginationLinkImpl instance) =>
    <String, dynamic>{
      'maxPage': instance.maxPage,
    };
