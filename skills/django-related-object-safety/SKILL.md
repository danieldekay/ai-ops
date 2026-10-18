---
name: "django-related-object-safety"
description: "Safe access to related objects in Django views using _related_or_none helper to prevent RelatedObjectDoesNotExist exceptions when optional relationships are missing."
version: 1
created: "2026-05-11"
updated: "2026-05-11"
---
## When to Use
Use this skill when working with Django views that access optional related objects through foreign keys or one-to-one relationships. Essential for handling cases where database records exist without their related counterparts.

## Procedure
1. **Identify risky direct access**: Look for `.related_object` access in view methods
2. **Locate existing helper**: Check if `_related_or_none()` helper exists in the same file
3. **Replace direct access**: Replace `obj.related_object` with `_related_or_none(obj.related_object)`
4. **Handle None responses**: Return appropriate HTTP responses (404, 400, etc.) when None is returned
5. **Update templates**: Ensure templates handle None values gracefully with conditional rendering

## Pitfalls
- Don't use for required relationships that should always exist - these indicate data integrity issues
- Remember to update both the view logic and template rendering
- Test edge cases where the related object might be missing during development

## Verification
- Test with existing data that has all relationships
- Test with missing related objects
- Verify appropriate error responses are returned
- Check template rendering with and without related data