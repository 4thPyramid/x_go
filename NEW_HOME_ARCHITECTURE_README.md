# X-GO New Home Architecture

## نظرة عامة
تم إعادة تصميم وهيكلة صفحة الهوم والفلتر للتطبيق باستخدام Clean Architecture مع فصل المسؤوليات بشكل كامل.

## البنية الجديدة

### 1. Domain Layer
- **Entities**: تحتوي على `CarEntity`, `FilterBrand`, `FilterType`, `FilterData`
- **Repository Interface**: `NewHomeRepository`
- **Use Cases**:
  - `GetNewCarsUseCase`: لجلب جميع السيارات
  - `GetNewFilterDataUseCase`: لجلب بيانات الفلتر (البراندات والأنواع)
  - `SearchNewCarsUseCase`: للبحث عن السيارات
  - `GetBrandModelsUseCase`: لجلب موديلات براند معين

### 2. Data Layer
- **Models**: `CarModel`, `FilterResponse`, `FilterParams`
- **Data Sources**: `NewHomeRemoteDataSource`
- **Repository Implementation**: `NewHomeRepositoryImpl`

### 3. Presentation Layer
#### Cubits (مفصولة حسب المسؤولية):
1. **NewHomeCubit**: إدارة عرض جميع السيارات والـ pagination
2. **SearchCubit**: إدارة البحث مع debouncing وcaching
3. **FilterCubit**: إدارة الفلاتر المختلفة
4. **BrandModelsCubit**: إدارة عرض موديلات البراند المحدد

#### Widgets:
- `NewCarListWidget`: عرض قائمة السيارات
- `NewSearchWidget`: البحث
- `NewFilterWidget`: الفلتر
- `NewBrandsWidget`: العلامات التجارية

## الميزات الجديدة

### 1. البحث المحسن
- Debouncing للتقليل من استهلاك API
- Cache للنتائج المتكررة
- عرض منفصل لنتائج البحث

### 2. الفلتر المطور
- إمكانية الفلترة حسب:
  - العلامة التجارية
  - نوع السيارة
  - السنة
  - النطاق السعري
- عرض منفصل للنتائج المفلترة
- إظهار الفلاتر النشطة

### 3. عرض العلامات التجارية
- Grid view للبراندات
- عرض موديلات كل براند منفصل
- Cache للموديلات

### 4. واجهة تبويبية
- تبويب للتنقل بين الأقسام المختلفة
- تصميم responsive ومتجاوب

## كيفية الاستخدام

### 1. إعداد الـ Service Locator
```dart
import 'package:x_go/features/home/new_home_service_locator.dart';

void main() {
  // Initialize the service locator
  setupNewHomeServices();
  
  runApp(MyApp());
}
```

### 2. استخدام الصفحة الجديدة
```dart
import 'package:x_go/features/home/presentation/views/new_home_wrapper.dart';

// في navigation أو routing
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const NewHomeWrapper(),
  ),
);
```

### 3. مثال كامل
```dart
import 'package:x_go/features/home/presentation/views/new_home_example.dart';

// استخدم NewHomeExample كصفحة مستقلة
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const NewHomeExample();
  }
}
```

## الـ API المتوقع

### 1. Home API
**GET /api/user/Home**

Parameters:
- `page`: رقم الصفحة
- `search`: نص البحث
- `brand`: العلامة التجارية
- `type`: نوع السيارة
- `year`: سنة الصنع
- `min_price`: أقل سعر
- `max_price`: أعلى سعر

Response Format:
```json
{
  "data": [
    {
      "id": "1",
      "attributes": {
        "year": "2022",
        "price": "3500.00",
        "engine_type": "Hybrid",
        "transmission_type": "Automatic",
        "seat_type": "leather",
        "seats_count": 5,
        "acceleration": "8.20",
        "image": "https://..."
      },
      "relationship": {
        "Model Names": {
          "model_name_id": "1",
          "model_name": "RAV4"
        },
        "Types": {
          "type_id": "1",
          "type_name": "SUV"
        },
        "Brand": {
          "brand_id": 1,
          "brand_name": "Toyota"
        }
      }
    }
  ],
  "meta": {
    "current_page": 1,
    "total": 10,
    "per_page": 10
  }
}
```

### 2. Filter API
**GET /api/user/filter**

Response Format:
```json
{
  "brands": [
    {
      "id": "1",
      "attributes": {
        "name": "Toyota",
        "logo": "https://..."
      }
    }
  ],
  "types": [
    {
      "name": "suv"
    }
  ],
  "max_price": "9000.00",
  "min_price": "2000.00"
}
```

## نصائح للتطوير

### 1. إضافة فلتر جديد
```dart
// في FilterCubit
Future<void> applyCustomFilter(String customParam) async {
  final params = FilterParams(
    customField: customParam,
    page: 1,
  );
  await applyFilter(params);
}
```

### 2. إضافة ميزة جديدة للبحث
```dart
// في SearchCubit
Future<void> searchByCustomCriteria(String criteria) async {
  // Your custom search logic
}
```

### 3. تخصيص العرض
يمكنك تخصيص أي من الـ widgets الموجودة أو إنشاء widgets جديدة باستخدام نفس الـ Cubits.

## الفوائد من البنية الجديدة

1. **فصل المسؤوليات**: كل cubit له مسؤولية واحدة واضحة
2. **إعادة الاستخدام**: يمكن استخدام أي cubit أو widget منفصلاً
3. **سهولة الاختبار**: كل component منفصل ويمكن اختباره بسهولة
4. **الأداء المحسن**: استخدام cache ومنع الطلبات المتكررة
5. **UX محسن**: تجربة مستخدم أفضل مع feedback مناسب

## ملاحظات مهمة

1. تأكد من تهيئة `setupNewHomeServices()` قبل استخدام الصفحة
2. الـ widgets تستخدم `flutter_screenutil` للResponsive Design
3. تم إضافة error handling شامل في جميع المستويات
4. يمكن استخدام الكود الجديد بجانب الكود القديم دون تعارض

## المتطلبات

- Flutter SDK
- Packages: `flutter_bloc`, `get_it`, `dio`, `dartz`, `flutter_screenutil`

## التشغيل

1. تأكد من إضافة الـ dependencies المطلوبة في `pubspec.yaml`
2. نفذ `flutter pub get`
3. اتبع المثال في `new_home_example.dart`
