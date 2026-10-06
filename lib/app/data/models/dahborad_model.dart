import 'dart:convert';

import 'package:japbusi/app/data/models/federation_model.dart';
import 'package:japbusi/app/data/models/grievance_by_category_model.dart';
import 'package:japbusi/app/data/models/grievance_each_day_model.dart';
import 'package:japbusi/app/data/models/grievance_model.dart';
import 'package:japbusi/app/data/models/provinces_by_category.dart';
import 'package:japbusi/app/data/models/visitor_stat_model.dart';

class Dashboard {
  final List<Federation> federations;
  final List<VisitorStat> visitorStats;
  final List<dynamic> federationVisitors;
  final dynamic totalMembersFederations;
  final int totalVisitors;
  final int totalArticle;
  final int totalViewsArticle;
  final int totalViewsEvent;
  final int totalViewsReport;
  final int totalViewsBerita;
  final int totalViewsBook;
  final int totalGaleri;
  final int totalViewsGaleri;
  final int totalEvents;
  final int totalViewsEvents;
  final int totalViewsVideo;
  final int totalContact;
  final int totalViewsProgram;
  final int totalGrievances;
  final int totalGrievancesWaiting;
  final int totalFederations;
  final int totalFederationsNotJoined;
  final List<GrievancesEachDay> grievancesEachDay;
  final GrievancesByCategory grievancesByCategory;
  final Map<String, int> grievancesByFederation;
  final int totalMale;
  final int totalFemale;
  final int totalPopulation;
  final int totalPelapor;
  final ProvincesByCategory provincesByCategory;
  final List<Griveance> recentGrievances;

  Dashboard({
    required this.federations,
    required this.visitorStats,
    required this.federationVisitors,
    required this.totalMembersFederations,
    required this.totalVisitors,
    required this.totalArticle,
    required this.totalViewsArticle,
    required this.totalViewsEvent,
    required this.totalViewsReport,
    required this.totalViewsBerita,
    required this.totalViewsBook,
    required this.totalGaleri,
    required this.totalViewsGaleri,
    required this.totalEvents,
    required this.totalViewsEvents,
    required this.totalViewsVideo,
    required this.totalContact,
    required this.totalViewsProgram,
    required this.totalGrievances,
    required this.totalGrievancesWaiting,
    required this.totalFederations,
    required this.totalFederationsNotJoined,
    required this.grievancesEachDay,
    required this.grievancesByCategory,
    required this.grievancesByFederation,
    required this.totalMale,
    required this.totalFemale,
    required this.totalPopulation,
    required this.totalPelapor,
    required this.provincesByCategory,
    required this.recentGrievances,
  });

  Dashboard copyWith({
    List<Federation>? federations,
    List<VisitorStat>? visitorStats,
    List<dynamic>? federationVisitors,
    dynamic totalMembersFederations,
    int? totalVisitors,
    int? totalArticle,
    int? totalViewsArticle,
    int? totalViewsEvent,
    int? totalViewsReport,
    int? totalViewsBerita,
    int? totalViewsBook,
    int? totalGaleri,
    int? totalViewsGaleri,
    int? totalEvents,
    int? totalViewsEvents,
    int? totalViewsVideo,
    int? totalContact,
    int? totalViewsProgram,
    int? totalGrievances,
    int? totalGrievancesWaiting,
    int? totalFederations,
    int? totalFederationsNotJoined,
    List<GrievancesEachDay>? grievancesEachDay,
    GrievancesByCategory? grievancesByCategory,
    Map<String, int>? grievancesByFederation,
    int? totalMale,
    int? totalFemale,
    int? totalPopulation,
    int? totalPelapor,
    ProvincesByCategory? provincesByCategory,
    List<Griveance>? recentGrievances,
  }) => Dashboard(
    federations: federations ?? this.federations,
    visitorStats: visitorStats ?? this.visitorStats,
    federationVisitors: federationVisitors ?? this.federationVisitors,
    totalMembersFederations:
        totalMembersFederations ?? this.totalMembersFederations,
    totalVisitors: totalVisitors ?? this.totalVisitors,
    totalArticle: totalArticle ?? this.totalArticle,
    totalViewsArticle: totalViewsArticle ?? this.totalViewsArticle,
    totalViewsEvent: totalViewsEvent ?? this.totalViewsEvent,
    totalViewsReport: totalViewsReport ?? this.totalViewsReport,
    totalViewsBerita: totalViewsBerita ?? this.totalViewsBerita,
    totalViewsBook: totalViewsBook ?? this.totalViewsBook,
    totalGaleri: totalGaleri ?? this.totalGaleri,
    totalViewsGaleri: totalViewsGaleri ?? this.totalViewsGaleri,
    totalEvents: totalEvents ?? this.totalEvents,
    totalViewsEvents: totalViewsEvents ?? this.totalViewsEvents,
    totalViewsVideo: totalViewsVideo ?? this.totalViewsVideo,
    totalContact: totalContact ?? this.totalContact,
    totalViewsProgram: totalViewsProgram ?? this.totalViewsProgram,
    totalGrievances: totalGrievances ?? this.totalGrievances,
    totalGrievancesWaiting:
        totalGrievancesWaiting ?? this.totalGrievancesWaiting,
    totalFederations: totalFederations ?? this.totalFederations,
    totalFederationsNotJoined:
        totalFederationsNotJoined ?? this.totalFederationsNotJoined,
    grievancesEachDay: grievancesEachDay ?? this.grievancesEachDay,
    grievancesByCategory: grievancesByCategory ?? this.grievancesByCategory,
    grievancesByFederation:
        grievancesByFederation ?? this.grievancesByFederation,
    totalMale: totalMale ?? this.totalMale,
    totalFemale: totalFemale ?? this.totalFemale,
    totalPopulation: totalPopulation ?? this.totalPopulation,
    totalPelapor: totalPelapor ?? this.totalPelapor,
    provincesByCategory: provincesByCategory ?? this.provincesByCategory,
    recentGrievances: recentGrievances ?? this.recentGrievances,
  );

  factory Dashboard.fromRawJson(String str) =>
      Dashboard.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Dashboard.fromJson(Map<String, dynamic> json) => Dashboard(
    federations: List<Federation>.from(
      json["federations"].map((x) => Federation.fromJson(x)),
    ),
    visitorStats: List<VisitorStat>.from(
      json["visitor_stats"].map((x) => VisitorStat.fromJson(x)),
    ),
    federationVisitors: List<dynamic>.from(
      json["federation_visitors"].map((x) => x),
    ),
    totalMembersFederations: json["total_members_federations"],
    totalVisitors:
        (json["total_visitors"] != null && json["total_visitors"] is int)
        ? json["total_visitors"]
        : int.tryParse(json["total_visitors"]?.toString() ?? '') ?? 0,
    totalArticle:
        (json["total_article"] != null && json["total_article"] is int)
        ? json["total_article"]
        : int.tryParse(json["total_article"]?.toString() ?? '') ?? 0,
    totalViewsArticle:
        (json["total_views_article"] != null &&
            json["total_views_article"] is int)
        ? json["total_views_article"]
        : int.tryParse(json["total_views_article"]?.toString() ?? '') ?? 0,
    totalViewsEvent:
        (json["total_views_event"] != null && json["total_views_event"] is int)
        ? json["total_views_event"]
        : int.tryParse(json["total_views_event"]?.toString() ?? '') ?? 0,
    totalViewsReport:
        (json["total_views_report"] != null &&
            json["total_views_report"] is int)
        ? json["total_views_report"]
        : int.tryParse(json["total_views_report"]?.toString() ?? '') ?? 0,
    totalViewsBerita:
        (json["total_views_berita"] != null &&
            json["total_views_berita"] is int)
        ? json["total_views_berita"]
        : int.tryParse(json["total_views_berita"]?.toString() ?? '') ?? 0,
    totalViewsBook:
        (json["total_views_book"] != null && json["total_views_book"] is int)
        ? json["total_views_book"]
        : int.tryParse(json["total_views_book"]?.toString() ?? '') ?? 0,
    totalGaleri: (json["total_galeri"] != null && json["total_galeri"] is int)
        ? json["total_galeri"]
        : int.tryParse(json["total_galeri"]?.toString() ?? '') ?? 0,
    totalViewsGaleri:
        (json["total_views_galeri"] != null &&
            json["total_views_galeri"] is int)
        ? json["total_views_galeri"]
        : int.tryParse(json["total_views_galeri"]?.toString() ?? '') ?? 0,
    totalEvents: (json["total_events"] != null && json["total_events"] is int)
        ? json["total_events"]
        : int.tryParse(json["total_events"]?.toString() ?? '') ?? 0,
    totalViewsEvents:
        (json["total_views_events"] != null &&
            json["total_views_events"] is int)
        ? json["total_views_events"]
        : int.tryParse(json["total_views_events"]?.toString() ?? '') ?? 0,
    totalViewsVideo:
        (json["total_views_video"] != null && json["total_views_video"] is int)
        ? json["total_views_video"]
        : int.tryParse(json["total_views_video"]?.toString() ?? '') ?? 0,
    totalContact:
        (json["total_contact"] != null && json["total_contact"] is int)
        ? json["total_contact"]
        : int.tryParse(json["total_contact"]?.toString() ?? '') ?? 0,
    totalViewsProgram:
        (json["total_views_program"] != null &&
            json["total_views_program"] is int)
        ? json["total_views_program"]
        : int.tryParse(json["total_views_program"]?.toString() ?? '') ?? 0,
    totalGrievances:
        (json["total_grievances"] != null && json["total_grievances"] is int)
        ? json["total_grievances"]
        : int.tryParse(json["total_grievances"]?.toString() ?? '') ?? 0,
    totalGrievancesWaiting:
        (json["total_grievances_waiting"] != null &&
            json["total_grievances_waiting"] is int)
        ? json["total_grievances_waiting"]
        : int.tryParse(json["total_grievances_waiting"]?.toString() ?? '') ?? 0,
    totalFederations:
        (json["total_federations"] != null && json["total_federations"] is int)
        ? json["total_federations"]
        : int.tryParse(json["total_federations"]?.toString() ?? '') ?? 0,
    totalFederationsNotJoined:
        (json["total_federations_not_joined"] != null &&
            json["total_federations_not_joined"] is int)
        ? json["total_federations_not_joined"]
        : int.tryParse(
                json["total_federations_not_joined"]?.toString() ?? '',
              ) ??
              0,
    grievancesEachDay: List<GrievancesEachDay>.from(
      json["grievances_each_day"].map((x) => GrievancesEachDay.fromJson(x)),
    ),
    grievancesByCategory: GrievancesByCategory.fromJson(
      json["grievances_by_category"],
    ),
    grievancesByFederation: Map.from(json["grievances_by_federation"]).map(
      (k, v) => MapEntry<String, int>(
        k,
        (v != null && v is int) ? v : int.tryParse(v?.toString() ?? '') ?? 0,
      ),
    ),
    totalMale: (json["total_male"] != null && json["total_male"] is int)
        ? json["total_male"]
        : int.tryParse(json["total_male"]?.toString() ?? '') ?? 0,
    totalFemale: (json["total_female"] != null && json["total_female"] is int)
        ? json["total_female"]
        : int.tryParse(json["total_female"]?.toString() ?? '') ?? 0,
    totalPopulation:
        (json["total_population"] != null && json["total_population"] is int)
        ? json["total_population"]
        : int.tryParse(json["total_population"]?.toString() ?? '') ?? 0,
    totalPelapor:
        (json["total_pelapor"] != null && json["total_pelapor"] is int)
        ? json["total_pelapor"]
        : int.tryParse(json["total_pelapor"]?.toString() ?? '') ?? 0,
    provincesByCategory: ProvincesByCategory.fromJson(
      json["provinces_by_category"],
    ),
    recentGrievances: json['grievances'] != null
        ? List<Griveance>.from(
            (json["grievances"] as List).map(
              (x) => Griveance.fromJson(Map<String, dynamic>.from(x)),
            ),
          )
        : [], // Handle null case
  );

  Map<String, dynamic> toJson() => {
    "federations": List<dynamic>.from(federations.map((x) => x.toJson())),
    "visitor_stats": List<dynamic>.from(visitorStats.map((x) => x.toJson())),
    "federation_visitors": List<dynamic>.from(federationVisitors.map((x) => x)),
    "total_members_federations": totalMembersFederations,
    "total_visitors": totalVisitors,
    "total_article": totalArticle,
    "total_views_article": totalViewsArticle,
    "total_views_event": totalViewsEvent,
    "total_views_report": totalViewsReport,
    "total_views_berita": totalViewsBerita,
    "total_views_book": totalViewsBook,
    "total_galeri": totalGaleri,
    "total_views_galeri": totalViewsGaleri,
    "total_events": totalEvents,
    "total_views_events": totalViewsEvents,
    "total_views_video": totalViewsVideo,
    "total_contact": totalContact,
    "total_views_program": totalViewsProgram,
    "total_grievances": totalGrievances,
    "total_grievances_waiting": totalGrievancesWaiting,
    "total_federations": totalFederations,
    "total_federations_not_joined": totalFederationsNotJoined,
    "grievances_each_day": List<dynamic>.from(
      grievancesEachDay.map((x) => x.toJson()),
    ),
    "grievances_by_category": grievancesByCategory.toJson(),
    "grievances_by_federation": Map.from(
      grievancesByFederation,
    ).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "total_male": totalMale,
    "total_female": totalFemale,
    "total_population": totalPopulation,
    "total_pelapor": totalPelapor,
    "provinces_by_category": provincesByCategory.toJson(),
    "grievances": List<Griveance>.from(recentGrievances.map((x) => x.toJson())),
  };
}
