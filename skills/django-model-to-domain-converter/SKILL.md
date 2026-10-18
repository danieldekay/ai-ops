---
name: "django-model-to-domain-converter"
description: "Add to_domain methods to Django models for Clean Architecture conversion from infrastructure layer to domain entities"
version: 1
created: "2026-05-10"
updated: "2026-05-10"
---
## When to Use
Use this skill when working with Django models in a Clean Architecture project and need to convert infrastructure layer models to domain entities. Applies when adding `to_domain` methods to map ORM models to framework-free domain objects.

## Procedure
1. **Identify the domain entity structure**
   - Read the domain entity file (e.g., `src/tangoatlas/domain/auth/user.py`)
   - Understand the dataclass structure and required fields
   - Note any value objects or complex types used

2. **Locate the Django model**
   - Find the corresponding infrastructure layer model (e.g., `src/tangoatlas/infrastructure/django/auth/models.py`)
   - Identify the model class that needs the `to_domain` method

3. **Implement the to_domain method**
   ```python
   def to_domain(self) -> DomainEntity:
       """Convert Django model to domain entity.
       
       Returns:
           DomainEntity: Framework-free domain object
       """
       return DomainEntity(
           id=self.id,
           # Map fields from model to domain entity
           field_name=self.field_name,
           # Handle optional fields
           optional_field=self.optional_field if self.optional_field else None,
           # Convert value objects
           coordinates=Coordinates(
               latitude=self.point.y,
               longitude=self.point.x
           )
       )
   ```

4. **Handle field mapping**
   - Direct field mapping: `field=self.field`
   - Optional fields: `field=self.field if self.field else None`
   - Value objects: Create instances with proper typing
   - PostGIS coordinates: Extract from PointField using `.x` and `.y`
   - Foreign keys: Convert to domain references or IDs

5. **Add typing and documentation**
   - Import the domain entity type
   - Add return type annotation
   - Include docstring explaining the conversion
   - Handle TYPE_CHECKING imports properly

6. **Test the conversion**
   - Verify all required fields are mapped
   - Check optional field handling
   - Test with edge cases (null values, empty strings)
   - Ensure no framework dependencies leak into domain

## Pitfalls
- **Circular imports**: Use TYPE_CHECKING guard to prevent import cycles
- **Missing fields**: Ensure all domain entity fields are mapped from model
- **Null handling**: Properly handle optional/nullable fields in domain
- **Framework leakage**: Never import Django classes in domain layer
- **PostGIS coordinates**: Remember PointField uses (x, y) not (lat, lon)

## Verification
- Run type checking with basedpyright
- Verify no import errors in domain layer
- Test conversion with sample data
- Check that domain entities remain framework-free