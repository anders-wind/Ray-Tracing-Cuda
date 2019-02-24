#pragma once

#include <math.h>
#include "vec3.cuh"
#include "ray.cuh"
#include "hitable.cuh"

struct sphere : public hitable {
	vec3 _center;
	float _radius;
	rgb _color;

	sphere() = default;
	sphere(const vec3& center, float radius, const rgb& color) : _center(center), _radius(radius), _color(color) {
	}

	bool hit(const ray& r, float t_min, float t_max, hit_record& out) const override {
		vec3 oc = r.origin() - _center;
		float a = dot(r.direction(), r.direction());
		float b = dot(oc, r.direction());
		float c = dot(oc, oc) - _radius * _radius;
		float discriminant = b * b - a * c;

		if (discriminant > 0) {
			float temp = (-b - sqrt(b*b - a * c)) / a;
			if (temp < t_max && temp > t_min) {
				out.t = temp;
				out.p = r.point_at_parameter(temp);
				out.normal = (out.p - _center) / _radius;
				return true;
			}

			temp = (-b + sqrt(b*b - a * c)) / a;
			if (temp < t_max && temp > t_min) {
				out.t = temp;
				out.p = r.point_at_parameter(temp);
				out.normal = (out.p - _center) / _radius;
				return true;
			}
		}
		return false;
	}

	vec3 normal(const vec3& position) const {
		return _center - position;
	}

	rgb color() const {
		return _color; // todo
	}
};