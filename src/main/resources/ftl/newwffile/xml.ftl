<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${basePackage}.mapper.${className}Mapper">
	<sql id="Base_Column_List" ><#list attrs as attr><#if (attr_index>0)>,</#if>
		t.${attr.columnName} ${attr.camelName}</#list>
	</sql>

	<sql id="Base_Query_Where" >
		<where>
		<#list attrs as attr>
		<#if attr.typeName?contains("Date")>
		<if test="paramCondition.${attr.camelName}Begin != null">
			and t.${attr.columnName}<#noparse> &gt;= #{paramCondition.</#noparse>${attr.camelName}Begin<#noparse>}</#noparse>
		</if>
		<if test="paramCondition.${attr.camelName}End != null">
			and t.${attr.columnName}<#noparse> &lt;= #{paramCondition.</#noparse>${attr.camelName}End<#noparse>}</#noparse>
		</if>
		<if test="paramCondition.${attr.camelName} != null">
			and t.${attr.columnName} = <#noparse>#{paramCondition.</#noparse>${attr.camelName}<#noparse>}</#noparse>
		</if>
		<#else>
		<#if (attr.queryByLike > 0)>
		<if test="paramCondition.${attr.camelName} != null">
			and t.${attr.columnName} like concat('%',<#noparse>#{paramCondition.</#noparse>${attr.camelName}<#noparse>}</#noparse>,'%')
		</if>
		<#else>
		<if test="paramCondition.${attr.camelName} != null">
			and t.${attr.columnName} = <#noparse>#{paramCondition.</#noparse>${attr.camelName}<#noparse>}</#noparse>
		</if>
		</#if>
		</#if>
		</#list>
		<#if hasHeadId=="Y">
		<if test="paramCondition.headIdList != null">
			and	t.head_id in
			<foreach collection="paramCondition.headIdList" item="headValue" index="index" open="(" close=")" separator=",">
				<#noparse>#{headValue}</#noparse>
			</foreach>
		</if>
		</#if>
		<#if hasUserId=="Y">
		<if test="paramCondition.userIdList != null">
			and	t.user_id in
			<foreach collection="paramCondition.userIdList" item="userIdValue" index="index" open="(" close=")" separator=",">
				<#noparse>#{userIdValue}</#noparse>
			</foreach>
		</if>
		</#if>
		</where>
	</sql>

	<select id="customList" resultType="${basePackage}.model.${className}Bean" parameterType="${basePackage}.model.${className}Bean">
		select
		<include refid="Base_Column_List"/>
		from ${tableName} t
		<include refid="Base_Query_Where"/>
	</select>

	<select id="customPageList" resultType="${basePackage}.model.${className}Bean" parameterType="${basePackage}.model.${className}Bean">
		select
		<include refid="Base_Column_List"/>
		from ${tableName} t
		<include refid="Base_Query_Where"/>
	</select>
</mapper>