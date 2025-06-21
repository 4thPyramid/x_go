String determineMedal(int totalPoints) {
  if (totalPoints < 100) {
    return "ستحصل على الميدالية البرونزية إذا حصلت على ${100 - totalPoints} نقاط إضافية.";
  } else if (totalPoints < 200) {
    return "ستحصل على الميدالية الفضية إذا حصلت على ${200 - totalPoints} نقاط إضافية.";
  } else if (totalPoints < 300) {
    return "ستحصل على الميدالية الذهبية إذا حصلت على ${300 - totalPoints} نقاط إضافية.";
  } else {
    return "لقد حصلت على جميع الميداليات!";
  }
}
