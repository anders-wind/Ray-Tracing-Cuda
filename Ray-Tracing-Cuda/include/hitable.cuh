#pragma once
#include "ray.cuh"

struct hit_record {
	float t;
	vec3 p;
	vec3 normal;
};

struct hitable {
	virtual bool hit(const ray& r, float t_min, float t_max, hit_record& out) const = 0;
};