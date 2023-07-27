/*

Cleaning Data in SQL Queries

This dataset pertains to housing data from Nashville. The cleaning process involves 
identifying missing values and making them ready for analysis. I employed various 
SQL functions to produce a more standard dataset and explained the process throughout 
the code. I enhanced the overall quality and integrity of the information for insights 
and decision-making in the domain of Nashville's housing market.

*/



select *
from dbo.NashvilleHousing

/*
I identified that the Sales Date column contained irrelevant values. In response, I made 
changes to the values in the column by altering them to become a standardized date format.
This ensures data consistency.

*/


select saledateconverted
	, CONVERT (Date, SaleDate)
from dbo.nashvillehousing

update nashvillehousing
	set SaleDate = CONVERT(Date,SaleDate)

alter table nashvillehousing
add SaleDateConverted date;

update nashvillehousing
set SaleDateConverted = convert(date,saledate)



/*

I observed the Property Address column contains a significant number of null values. After 
examining the Parcel ID column and Property Address column, I concluded that similar Parcel IDs 
indicate identical addresses. I used the join clause to populate the null values in the Property 
Address column with the address information. This ensures data completeness and coherence.

*/

select *
from dbo.nashvillehousing
--where PropertyAddress is null
order by ParcelID

select 
	verison1.ParcelID
	,verison1.PropertyAddress
	,verison2.ParcelID
	,verison2.PropertyAddress
	,ISNULL (verison1.PropertyAddress, verison2.PropertyAddress)
from dbo.nashvillehousing verison1
join dbo.nashvillehousing verison2
	on verison1.ParcelID = verison2.ParcelID
	AND verison1.[uniqueID] <> verison2.[uniqueID]
	where verison1.PropertyAddress is null

Update verison1
set propertyaddress = ISNULL (verison1.PropertyAddress, verison2.PropertyAddress)
from dbo.nashvillehousing verison1
join dbo.nashvillehousing verison2
	on verison1.ParcelID = verison2.ParcelID
	AND verison1.[uniqueID] <> verison2.[uniqueID]
	where verison1.PropertyAddress is null



/*

The format of the Property Address column is a combination of the street address and city 
information, but I believe it is more uniform to divide this data. I used substring and charindex 
functions to partition the relevant values. Additionally, I applied a similar approach to the 
Owner Address column, which had a combination of the street address, city, and state. I used the 
parsename function to partition the information. This enhances the data uniformity and creates a 
well-structured dataset. 

*/

select 
	substring(propertyaddress, 1, charindex(',', propertyaddress) - 1) as AddressLine1
	,substring(propertyaddress, charindex(',', propertyaddress) +1, len(propertyaddress)) as City
from dbo.nashvillehousing

alter table nashvillehousing   
	add StreetAddress varchar(255);

update nashvillehousing
	set StreetAddress = substring(propertyaddress, 1, charindex(',', propertyaddress) - 1)

alter table nashvillehousing   
	add City varchar(255);

update nashvillehousing
	set City = substring(propertyaddress, charindex(',', propertyaddress) +1, len(propertyaddress))

select 
	owneraddress
from dbo.nashvillehousing

select
	parsename (replace(owneraddress, ',' , '.'),3)
	, parsename (replace(owneraddress, ',' , '.'),2)
	,parsename (replace(owneraddress, ',' , '.'),1)
	from dbo.nashvillehousing

alter table nashvillehousing
add OwnerStreetAddress varchar(255);

update nashvillehousing
	set OwnerStreetAddress =  parsename (replace(owneraddress, ',' , '.'),3)

alter table nashvillehousing
add OwnerCity varchar(255);

update nashvillehousing
	set OwnerCity =  parsename (replace(owneraddress, ',' , '.'),2)

alter table nashvillehousing
add OwnerState varchar(255);

update nashvillehousing
	set OwnerState =  parsename (replace(owneraddress, ',' , '.'),1)

select 
	*
from dbo.nashvillehousing



/*

Looking at the Sold As Vacant column, I observed it contained a combination of "Yes," "No,",
"Y," and "N" values, indicating a lack of uniformity. I modified the "Y" values to be "Yes," 
and the "N" values to be "No." This establishes a cohesive dataset. 

*/

select soldasvacant
	,case when soldasvacant like 'Y' then 'Yes'
		when soldasvacant like 'N' then 'No'
		else soldasvacant
		end
from dbo.nashvillehousing

update nashvillehousing
	set soldasvacant = case when soldasvacant like 'Y' then 'Yes'
		when soldasvacant like 'N' then 'No'
		else soldasvacant
		end

select 
	*
from dbo.nashvillehousing



/*

After reviewing the dataset, I found several columns that were deemed unnecessary.  
They have been successfully removed. This process aims to simplify the dataset, 
improving its clarity for further analysis.

*/

alter table dbo.nashvillehousing
	drop column propertyaddress
	,saledate
	,owneraddress
	,taxdistrict

select 
	*
from dbo.nashvillehousing
