<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${basePackage}.mapper.${className}Mapper">


	<!-- 通用查询映射结果 -->
	<resultMap id="BaseResultMap" type="${basePackage}.entity.${className}">
		<#list attrs as attr>
		<result column="${attr.columnName}" property="${attr.camelName}" />
		</#list>
	</resultMap>

	<!-- 通用查询结果列 -->
	<sql id="Base_Column_List"><#list attrs as attr><#if (attr_index>0)>,</#if>
		${attr.columnName} as ${attr.camelName}</#list>
	</sql>


	<select id="customList" resultType="${basePackage}.model.result.${className}Result" parameterType="${basePackage}.model.params.${className}Param">
		select
		<include refid="Base_Column_List"/>
		from ${tableName} where 1 = 1
	</select>

	<select id="customMapList" resultType="map" parameterType="${basePackage}.model.params.${className}Param">
		select
		<include refid="Base_Column_List"/>
		from ${tableName} where 1 = 1
	</select>

	<select id="customPageList" resultType="${basePackage}.model.result.${className}Result" parameterType="${basePackage}.model.params.${className}Param">
		select
		<include refid="Base_Column_List"/>
		from ${tableName} where 1 = 1
	</select>

	<select id="customPageMapList" resultType="map" parameterType="${basePackage}.model.params.${className}Param">
		select
		<include refid="Base_Column_List"/>
		from ${tableName} where 1 = 1
	</select>
</mapper>