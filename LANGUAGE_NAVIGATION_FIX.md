# حل مشكلة تغيير اللغة والانتقال للصفحة الخطأ

## المشكلة
عند تغيير اللغة، التطبيق ينقل المستخدم لصفحة أخرى بدلاً من البقاء في الصفحة الحالية وتحديث النصوص فوراً.

## الحل المطبق

### 1. تحديث الهيكل الأساسي للتطبيق
```dart
// lib/main.dart
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocalizationCubit>(
      create: (context) => getIt<LocalizationCubit>(),
      child: BlocBuilder<LocalizationCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp.router(
            routerConfig: router, // نفس الـ router بدون key
            locale: locale,
            // ... باقي الإعدادات
          );
        },
      ),
    );
  }
}
```

### 2. تحسين LocalizationCubit
```dart
Future<void> changeLanguage(Locale locale, BuildContext context) async {
  try {
    // حفظ في الكاش أولاً
    await CacheHelper.saveLanguageCode(locale.languageCode);
    
    // تحديث الـ cubit state أولاً لتحفيز إعادة البناء
    emit(locale);
    
    // تعيين الـ locale في EasyLocalization بدون تأثير على الـ navigation
    await context.setLocale(locale);
    
  } catch (e) {
    debugPrint('Error changing language: $e');
  }
}
```

### 3. تحديث طريقة تغيير اللغة
```dart
// في language_view.dart
onTap: () async {
  // تغيير اللغة أولاً
  await cubit.changeLanguageByCode(language['code']!, context);
  
  // إغلاق الحوار بعد تغيير اللغة
  if (context.mounted) {
    Navigator.of(context).pop();
    // إظهار رسالة التأكيد
  }
},
```

### 4. إنشاء Widgets مساعدة للتحديث الفوري
```dart
// LanguageAwareText - للنصوص التي تحتاج تحديث فوري
LanguageAwareText('language')

// LanguageAwareScaffold - للصفحات الكاملة
LanguageAwareScaffold(
  body: YourPageContent(),
)
```

## الفوائد الجديدة

✅ **لا انتقال غير مرغوب**: البقاء في نفس الصفحة عند تغيير اللغة  
✅ **تحديث فوري**: النصوص تتغير فوراً بدون hot restart  
✅ **اتجاه النص**: التبديل بين RTL و LTR فوراً  
✅ **استقرار التطبيق**: لا توجد أخطاء أو مشاكل في الـ navigation  

## كيفية الاستخدام

### للصفحات الجديدة:
```dart
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LanguageAwareScaffold(
      appBar: AppBar(title: LanguageAwareText('page_title')),
      body: Column(
        children: [
          LanguageAwareText('welcome_message'),
          // باقي المحتوى
        ],
      ),
    );
  }
}
```

### للنصوص المهمة:
```dart
// بدلاً من
Text(AppStrings.language.tr())

// استخدم
LanguageAwareText(AppStrings.language)
```

### للتحقق من الاتجاه:
```dart
if (context.isRTL) {
  // محتوى خاص بالعربية
}
```

## النتيجة
الآن عند تغيير اللغة من إعدادات الحساب:
1. النصوص تتغير فوراً
2. اتجاه النص يتغير فوراً (RTL/LTR)
3. المستخدم يبقى في نفس الصفحة
4. لا حاجة لـ hot restart أو reload
