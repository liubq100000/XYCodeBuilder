<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${basePackage}.domain.${className}">

	<insert id="insert" parameterType="${basePackage}.domain.${className}" useGeneratedKeys="true" keyProperty="id">
		insert into ${tableName} (<#list attrs as attr><#if (attr_index>0)>,</#if>${attr.columnName}</#list>)
		values (<#list attrs as attr><#if (attr_index>0)>,</#if><#noparse>#{</#noparse>${attr.camelName}<#noparse>}</#noparse></#list>)		
	</insert>

	<insert id="insertList" parameterType="list">
		insert into ${tableName} (<#list attrs as attr><#if (attr_index>0)>,</#if>${attr.columnName}</#list>)
		values
		<foreach collection="list" item="item" index="index" separator=",">
			(<#list attrs as attr><#if (attr_index>0)>,</#if><#noparse>#{item.</#noparse>${attr.camelName}<#noparse>}</#noparse></#list>)
		</foreach>
	</insert>

	<update id="update" parameterType="${basePackage}.domain.${className}">
		update ${tableName} set
		<#list attrs as attr>
		<if test="${attr.camelName} != null">${attr.columnName}=<#noparse>#{</#noparse>${attr.camelName}<#noparse>}</#noparse>,</if>
		</#list>		
	   	<#noparse>MODIFY_DATE = #{modifyDateNew} where ID = #{id} and MODIFY_DATE = #{modifyDate}</#noparse>
	</update>


	<sql id="Base_Column_List" ><#list attrs as attr><#if (attr_index>0)>,</#if>
		t.${attr.columnName} ${attr.camelName}</#list>
	</sql>
	
	<sql id="Base_Query_Where" >
		<where>
		<#list attrs as attr>
		<#if attr.typeName?contains("Date")>
			<if test="${attr.camelName}Begin != null">
				and t.${attr.columnName}<#noparse> &gt;= #{</#noparse>${attr.camelName}Begin<#noparse>}</#noparse>
			</if>
			<if test="${attr.camelName}End != null">
				and t.${attr.columnName}<#noparse> &lt;= #{</#noparse>${attr.camelName}End<#noparse>}</#noparse>
			</if>
			<if test="${attr.camelName} != null">
				and t.${attr.columnName} = <#noparse>#{</#noparse>${attr.camelName}<#noparse>}</#noparse>
			</if>
		<#else>
			<#if (attr.queryByLike > 0)>
			<if test="${attr.camelName} != null">
				and t.${attr.columnName} like concat('%',<#noparse>#{</#noparse>${attr.camelName}<#noparse>}</#noparse>,'%')
			</if>
			<#else>
			<if test="${attr.camelName} != null">
				and t.${attr.columnName} = <#noparse>#{</#noparse>${attr.camelName}<#noparse>}</#noparse>
			</if>
			</#if>
		</#if>
		</#list>
		<#noparse>
			<if test="primaryKeys != null">
				and t.id in
				<foreach collection="primaryKeys" item="primaryKey" index="index" open="(" close=")" separator=",">
					#{primaryKey}
				</foreach>
			</if>
		</#noparse>
		</where>
	</sql>
	<select id="query" parameterType="${basePackage}.domain.${className}" resultType="${basePackage}.domain.${className}">
		SELECT
		<include refid="Base_Column_List" />
		FROM ${tableName} t
		<include refid="Base_Query_Where"/>
		<if test="orderBy != null">
			<#noparse>order by ${orderBy}</#noparse>
		</if>
	</select>


	<select id="queryCount" parameterType="${basePackage}.domain.${className}" resultType="java.lang.Long">
		SELECT count(t.ID) FROM ${tableName} t
		<include refid="Base_Query_Where"/>
	</select>

	<delete id="deletePhysical"  parameterType="${basePackage}.domain.${className}">
    	delete from ${tableName}
		<where>
		<#noparse>
			<if test="id != null">
				and id = #{id}
			</if>
			<if test="primaryKeys != null">
				and id in
				<foreach collection="primaryKeys" item="primaryKey" index="index" open="(" close=")" separator=",">
					#{primaryKey}
				</foreach>
			</if>
		</#noparse>
		</where>
 	</delete>

	<update id="deleteLogic"  parameterType="${basePackage}.domain.${className}">
    	UPDATE ${tableName} t set t.delete_flag = 1,<#noparse>t.modify_user = #{modifyUser},t.modify_date = #{modifyDate}</#noparse>
		<where>
		<#noparse>
			<if test="id != null">
				and t.id = #{id}
			</if>
			<if test="primaryKeys != null">
				and t.id in
				<foreach collection="primaryKeys" item="primaryKey" index="index" open="(" close=")" separator=",">
					#{primaryKey}
				</foreach>
			</if>
		</#noparse>
		</where>
 	</update>
</mapper>